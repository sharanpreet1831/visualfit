//
//  StartJourneyViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 18/04/24.
//

import UIKit
import Vision


struct ImageResult: Codable {
    let image: String
}

class StartJourneyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet var selectedImageView: UIImageView!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var loadingIndicator : UIActivityIndicatorView?
    
    var userInstance = UserData.getInstance()
    let visionQueue = DispatchQueue.global(qos: .userInitiated)
    
    private var originalImage: UIImage?
    private var maskedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        PopUpView.layer.cornerRadius = 10
        print(userInstance.user.personalDetails)
        print(userInstance.user.goalDetails)
        print("=============================")
        print(userInstance.user)
        selectedImageView.isHidden = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func handleAllow(_ sender: UIButton) {
        print("tapped")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        let img = downsized(image: image)
        
        print("here it will upload")
        selectedImageView.image = img  // Display the compressed image
        userInstance.user.todayImage = img
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
    
    func handleTabBarChange(){
        print("button pressed")
        UserDefaults.standard.set("userState", forKey: "fitLatestUser")
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func handleUploadSuccess(image: UIImage, jsonResponse: [String: Any]) {
        if let transformationURL = jsonResponse["transformation"] as? String {
            print("Transformation URL: \(transformationURL)")
            getImageFromURL(stringURL: transformationURL) { image in
                DispatchQueue.main.async {
                    if let transformedImage = image {
                        self.selectedImageView.image = image
                        self.PopUpView.isHidden = true
                        self.selectedImageView.isHidden = false
                        self.userInstance.user.todayImage = image
                        self.userInstance.user.todayTransformedImage = transformedImage
                    } else {
                        print("Failed to load image from URL.")
                    }
                }
            }
        } else {
            print("Failed to extract transformation URL from response.")
        }
        
    }
    
    func handleUploadFailure() {
        // Handle failure case, show error message, retry option, etc.
    }
    
    @IBAction func handlePressDone(_ sender: UIBarButtonItem) {
        print("button pressed")
        UserDefaults.standard.set("userState", forKey: "fitLatestUser")
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }
}


private extension StartJourneyViewController{
    func fetchTheUpdatedImage() {
        DispatchQueue.main.async{
            guard let image = self.selectedImageView.image else { return }
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                return
            }
            let base64String = imageData.base64EncodedString()
            print("BASE64 String:", base64String.count)
            
            
            
            // ============================== Original Image
            guard let originalImageDownload = self.originalImage else {return}
            guard let originalImageData = originalImageDownload.jpegData(compressionQuality: 1.0) else {
                return
            }
            let base64StringOriginal = originalImageData.base64EncodedString()
            print("BASE64 String:", base64StringOriginal.count)
            
            // ======================== API CALL
            
            self.loadingIndicator = UIActivityIndicatorView()
            self.loadingIndicator?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            self.loadingIndicator?.backgroundColor = .white
            self.loadingIndicator?.layer.cornerRadius = 10
            self.loadingIndicator?.tintColor = .black
            self.loadingIndicator?.startAnimating()
            self.loadingIndicator?.center = self.view.center
            self.view.addSubview(self.loadingIndicator!)
            
            uploadTransformImage(originalImage: base64StringOriginal, maskImage: base64String, prompt: "converting into athletic lean body") { result in
                DispatchQueue.main.async{
                    self.loadingIndicator?.stopAnimating()
                    self.loadingIndicator?.removeFromSuperview()
                }
                switch result {
                case .success(let resultString):
                    // Handle success
                    print("Result: \(resultString)")
                    if let jsonData = resultString.data(using: .utf8) {
                        do {
                            // Decode JSON data into ImageResult object
                            let decoder = JSONDecoder()
                            let imageResult = try decoder.decode(ImageResult.self, from: jsonData)
                            
                            // Access the image string from the ImageResult object
                            let imageString = imageResult.image
                            print("Image String: \(imageString)")
                            
                            // Now you can further process the image string, such as converting it to data if it's in Base64 format
                            // For example, to convert a Base64 string to data:
                            if let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters) {
                                // You can use the imageData here for further processing like displaying the image
                                print("Image Data: \(imageData)")
                                DispatchQueue.main.async{
                                    if let image = UIImage(data: imageData) {
                                        // Assign the image to the UIImageView
                                        self.selectedImageView.image = image
                                        self.userInstance.user.todayTransformedImage = image
                                        self.handleTabBarChange()
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
                    // Handle error
                    print("Error: \(error)")
                }
            }
        }
    }
}






private extension StartJourneyViewController {
    func showPopup(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // Assuming `viewController` is the current view controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func process(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let isProcessingRequired = true
        
        guard isProcessingRequired else {
            selectedImageView.image = image
            return
        }
        
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
                //                self.updateUI(isProcessing: true)
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
                self.selectedImageView.image = UIImage(systemName: "photo")
                return;
            }
            
            if openPointsGroups.count < 2 {
                showPopup(message: "Picture is not clear")
                selectedImageView.image = UIImage(systemName: "photo")
                return
            }
            var i = 0
            var flag = false
            DispatchQueue.main.async{
                openPointsGroups.forEach { arr in
                    if(i < 2 && arr.count < 3){
                        self.showPopup(message: "this is not valid")
                        self.selectedImageView.image = UIImage(systemName: "photo")
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
            let printableTexts = texts.filter { $0.frame == nil }.map { $0.text }
            
            DispatchQueue.main.async {
                self.selectedImageView.image = image.draw(openPaths: openPointsGroups,
                                                          closedPaths: closedPointsGroups,
                                                          points: points,
                                                          
                                                          displayableTexts: framedTexts,
                                                          images: images,
                                                          rectangleWorkPoints: rectanglePointsWork)
                
                self.maskedImage = self.selectedImageView.image
                
            }
            fetchTheUpdatedImage()
        }
    }
    
}
struct DisplayableText {
    let frame: CGRect?
    let text: String
}


extension UIImage.Orientation {
    var cgOrientation: CGImagePropertyOrientation {
        switch self {
        case .up:
            return .up
        case .down:
            return .down
        case .left:
            return .left
        case .right:
            return .right
        case .upMirrored:
            return .upMirrored
        case .downMirrored:
            return .downMirrored
        case .leftMirrored:
            return .leftMirrored
        case .rightMirrored:
            return .rightMirrored
        @unknown default:
            return .up
        }
    }
}




