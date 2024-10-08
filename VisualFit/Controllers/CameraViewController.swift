//
//  CameraViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 03/05/24.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var addImage: UIImageView!
    var userInstance = UserData.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        openCameraSelf()
    }
    func openCameraSelf(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func navigateToMain(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
//        print("here it will upload")
        userInstance.user.todayImage = image
        addImage.image = image
        navigateToMain()
    }
}
