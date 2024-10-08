//
//  SummaryViewController.swift
//  VisualFit
//
//  Created by student on 05/05/24.
//

import UIKit
import Vision


class SummaryViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var PredictedBodyView: UIView!
    
    @IBOutlet weak var stepCountView: UIView!
    
    @IBOutlet weak var caloriesView: UIView!
    
    @IBOutlet weak var distanceView: UIView!
    
    @IBOutlet weak var weeklyGoalView: UIView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var challengeView1: UIView!
    
    @IBOutlet weak var challengeView2: UIView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var beforeImage: UIImageView!
    
    @IBOutlet weak var afterImage: UIImageView!
    
    var beforeImageClicked : UIImage = .demoBefore
    var userData = UserData.getInstance()
    var loadingIndicator : UIActivityIndicatorView?
    
    
    private var originalImage: UIImage?
    private var maskedImage: UIImage?
    let visionQueue = DispatchQueue.global(qos: .userInitiated)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dateLabel.text = Calendar.current.startOfDay(for: .now).formatted(date: .abbreviated, time: .omitted)
        PredictedBodyView.layer.cornerRadius = 10
        PredictedBodyView.layer.masksToBounds = true
        stepCountView.layer.cornerRadius = 10
        stepCountView.layer.masksToBounds = true
        caloriesView.layer.cornerRadius = 10
        caloriesView.layer.masksToBounds = true
        distanceView.layer.cornerRadius = 10
        distanceView.layer.masksToBounds = true
        weeklyGoalView.layer.cornerRadius = 10
        weeklyGoalView.layer.masksToBounds = true
        challengeView1.layer.cornerRadius = 10
        challengeView1.layer.masksToBounds = true
        challengeView2.layer.cornerRadius = 10
        challengeView2.layer.masksToBounds = true
        
        beforeImage.image = userData.user.todayImage
        afterImage.image = userData.user.todayTransformedImage
        
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator?.startAnimating()
        loadingIndicator?.center = CGPoint(x: view.bounds.midX, y: view.bounds.midX)
        afterImage.addSubview(loadingIndicator!)
        
    }
    //adding mainview in scrollview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.addSubview(mainView)
        scrollView.contentSize = mainView.frame.size
    }
    
//creating an alert when camera button is clicked

    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .alert)
        alertController.view.backgroundColor = .darkGray
        alertController.view.tintColor = .black
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photos", style: .default, handler:{
                action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
                
            })
            alertController.addAction(photoLibraryAction)
        }
        
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion:nil)
    }
   
    //unwind segue
    @IBAction func unwindToSummary(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
    }
}
extension SummaryViewController : UIImagePickerControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        let img = downsized(image: image)
        
        print("here it will upload")
        
        beforeImage.image = img
        afterImage.image = UIImage(named: "photo")
        userData.user.todayImage = img
        originalImage = img
        maskedImage = img
        process(img!)
        
    }
    private func downsized(image: UIImage?, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        guard let image = image else { return nil }
        let newWidth = view.frame.width * scale
        let newHeight = view.frame.width * image.size.height * scale / image.size.width
        
        return image.resizeImage(to: CGSize(width: newWidth, height: newHeight))
    }
}


private extension SummaryViewController{
    func fetchTheUpdatedImage() {
        DispatchQueue.main.async{
            guard let image = self.maskedImage else { return }
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return
            }
            let base64String = imageData.base64EncodedString()
            //print("BASE64 String:", base64String.count)
            
 
            guard let originalImageDownload = self.originalImage else {return}
            guard let originalImageData = originalImageDownload.jpegData(compressionQuality: 1.0) else {
                return
            }
            let base64StringOriginal = originalImageData.base64EncodedString()
            //print("BASE64 String:", base64StringOriginal.count)
            
            // ======================== API CALL
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = scene.windows.first else{
                print("Unable to find window")
                return
            }
            var summaryViewController = window.rootViewController
            while let presentedViewController = summaryViewController?.presentedViewController{
                summaryViewController = presentedViewController
            }

            self.loadingIndicator = UIActivityIndicatorView()
            self.loadingIndicator?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            self.loadingIndicator?.backgroundColor = .white
            self.loadingIndicator?.layer.cornerRadius = 10
            self.loadingIndicator?.tintColor = .black
            self.loadingIndicator?.startAnimating()
            self.loadingIndicator?.center = self.view.center
            summaryViewController?.view.addSubview(self.loadingIndicator!)
            
            uploadTransformImage(originalImage: base64StringOriginal, maskImage: base64String, prompt: "converting into athletic lean body") { result in
                
                DispatchQueue.main.async{
                    self.loadingIndicator?.stopAnimating()
                    self.loadingIndicator?.removeFromSuperview()
                }
                
                switch result {
                case .success(let resultString):
                    
//                    print("Result: \(resultString)")
                    if let jsonData = resultString.data(using: .utf8) {
                        do {
                            // Decode JSON data into ImageResult object
                            let decoder = JSONDecoder()
                            let imageResult = try decoder.decode(ImageResult.self, from: jsonData)
                            // Access the image string from the ImageResult object
                            let imageString = imageResult.image
//                            print("Image String: \(imageString)")

                            // base64 to Image
                            if let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters) {
//                                print("Image Data: \(imageData)")
                                DispatchQueue.main.async{
                                    if let image = UIImage(data: imageData) {
                                        // Assign the image to the UIImageView
                                        self.afterImage.image = image
                                        self.userData.user.todayTransformedImage = image
                                    } else {
                                        print("Error creating UIImage from imageData")
                                    }
                                }
                            } else {
                                print("Error converting image string to data")
                            }
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                        }
                    } else {
                        print("Failed to convert JSON string to data")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}





private extension SummaryViewController {
    func showPopup(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func process(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let isProcessingRequired = true
        
        visionQueue.async { [weak self] in
            guard let self = self else { return }
            let requests = [VNDetectHumanBodyPoseRequest()].compactMap { $0 }
            let requestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                       orientation: .init(image.imageOrientation),
                                                       options: [:])
            
            var processingTime: Double = 0.0
            
            do {
                let startProcessingDate = Date()
                try requestHandler.perform(requests)
                processingTime = (Date().timeIntervalSince(startProcessingDate) * 100).rounded() / 100
            } catch {
                print("Can't make the request due to \(error)")
            }
            
            let resultPointsProviders = requests.compactMap { $0 as? ResultPointsProviding }
            
            print(resultPointsProviders)
            
            let openPointsGroups = resultPointsProviders
                .flatMap { $0.openPointGroups(projectedOnto: image) }
            
            let closedPointsGroups = resultPointsProviders
                .flatMap { $0.closedPointGroups(projectedOnto: image) }
            
            let texts = resultPointsProviders
                .flatMap { $0.displayableTextPoints(projectedOnto: image) }
            
            var points: [CGPoint]?
            let isDetectingFaceLandmarks = requests.filter { ($0 as? VNDetectFaceLandmarksRequest)?.results?.isEmpty == false }.isEmpty == false
            
            points = resultPointsProviders
                .filter { !isDetectingFaceLandmarks || isDetectingFaceLandmarks && !($0 is VNDetectHumanBodyPoseRequest) }
                .flatMap { $0.pointsProjected(onto: image) }
            
            
            if(openPointsGroups.count == 0){
                showPopup(message: "Picture is not clear")
                self.beforeImage.image = UIImage(systemName: "photo")
                return;
            }
            
            if openPointsGroups.count < 2 {
                showPopup(message: "Picture is not clear")
                beforeImage.image = UIImage(systemName: "photo")
                return
            }
            var i = 0
            var flag = false
            DispatchQueue.main.async{
                openPointsGroups.forEach { arr in
                    if(i < 2 && arr.count < 3){
                        self.showPopup(message: "this is not valid")
                        self.beforeImage.image = UIImage(systemName: "photo")
                        flag = true
                        return
                    }
                    i = i + 1
                }
            }
            
            
            if flag {
                return
            }
            
            let rectanglePointsWork = [
                CGPoint(x: openPointsGroups[1][0].x - 50, y: openPointsGroups[1][0].y - 50),
                CGPoint(x: openPointsGroups[0][0].x + 50, y: openPointsGroups[0][0].y - 50),
                CGPoint(x: openPointsGroups[0][2].x + 50, y: openPointsGroups[0][2].y + 70),
                CGPoint(x: openPointsGroups[1][2].x - 50, y: openPointsGroups[1][2].y + 70)
            ]
            
            let images = resultPointsProviders.flatMap { $0.generatedImages }
            
            let framedTexts = texts.filter { $0.frame != nil }
            _ = texts.filter { $0.frame == nil }.map { $0.text }
            
            DispatchQueue.main.async {
                self.maskedImage = image.draw(openPaths: openPointsGroups,
                                              closedPaths: closedPointsGroups,
                                              points: points,
                                              
                                              displayableTexts: framedTexts,
                                              images: images,
                                              rectangleWorkPoints: rectanglePointsWork)
            }
            fetchTheUpdatedImage()
        }
    }
    
    
}
