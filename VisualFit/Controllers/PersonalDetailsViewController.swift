//
//  PersonalDetailsViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 18/04/24.
//

import UIKit

enum ModalType{
    case genderModal,heightModal,weightModal
}

class PersonalDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var HeightUIView: UIView!
    @IBOutlet weak var GenderUIView: UIView!
    @IBOutlet weak var WeightUIView: UIView!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var heightBtn: UIButton!
    @IBOutlet weak var weightBtn: UIButton!
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    @IBOutlet weak var genderModal: UIView!
    let genderArr = ["Male","Female","Others"]
    
    @IBOutlet weak var heightModal: UIView!
    let heightArr = Array(1...500)
    @IBOutlet weak var heightPickerView: UIPickerView!
    
    
    @IBOutlet weak var weightModal: UIView!
    var weightArr = [Any]()
    
    
    @IBOutlet weak var weightPickerView: UIPickerView!
    
    var modalType: ModalType = .genderModal
    
    var userInstance = UserData.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        genderModal.isHidden = true
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.selectRow(0, inComponent: 0, animated: true)
        
        
        heightModal.isHidden = true
        heightPickerView.delegate = self
        heightPickerView.dataSource = self
        
        
        weightModal.isHidden = true
        weightPickerView.delegate = self
        weightPickerView.dataSource = self
        for number in stride(from: 0.5, through: 655.5, by: 0.5) {
            if floor(number) == number {
                weightArr.append(Int(number))
            } else {
                weightArr.append(number)
            }
        }
        
        /// Gender UI View changes
        
        // Add rounded corners to top left and top right
        let maskPath = UIBezierPath(roundedRect: GenderUIView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        GenderUIView.layer.mask = maskLayer
        
        // Add bottom border
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: GenderUIView.frame.height - 1, width: GenderUIView.frame.width, height: 0.5)
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        GenderUIView.layer.addSublayer(borderLayer)
        
        /// Height UIView changes
        let borderLayerHeight = CALayer()
        borderLayerHeight.frame = CGRect(x: 0, y: HeightUIView.frame.height - 1, width: HeightUIView.frame.width, height: 0.5)
        borderLayerHeight.backgroundColor = UIColor.lightGray.cgColor
        HeightUIView.layer.addSublayer(borderLayerHeight)
        
        /// Weight UI View changes
        // Add rounded corners to top left and top right
        let maskPathWeight = UIBezierPath(roundedRect: WeightUIView.bounds,
                                          byRoundingCorners: [.bottomLeft, .bottomRight],
                                          cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayerWeight = CAShapeLayer()
        maskLayerWeight.path = maskPathWeight.cgPath
        WeightUIView.layer.mask = maskLayerWeight
        
        
        // Changing button Text according to Data
        
        if let gender = userInstance.user.personalDetails.gender{
            switch gender{
            case .Male:
                genderBtn.titleLabel?.text = "Male"
                break;
            case .Female:
                genderBtn.titleLabel?.text = "Female"
                break;
            case .Others:
                genderBtn.titleLabel?.text = "Others"
                break;
            }
        }
        else{
            genderBtn.titleLabel?.text = "Not Set"
        }
        
        // Height
        if let height = userInstance.user.personalDetails.height{            heightBtn.titleLabel?.text = "\(height)"
        }
        else{
            heightBtn.titleLabel?.text = "Not Set"
        }
        
        // Weight
        if let weight = userInstance.user.personalDetails.weight{
            weightBtn.titleLabel?.text = "\(weight)"
        }
        else{
            weightBtn.titleLabel?.text = "Not Set"
        }
        
    }
    
    @IBAction func genderBtn(_ sender: UIButton) {
        modalType = .genderModal
        UIView.animate(withDuration: 10) {
            self.genderModal.isHidden = false
        }
    }
    
    @IBAction func genderDoneBtn(_ sender: UIButton) {
        print(sender)
        print("genderBtn triggered")
        UIView.animate(withDuration: 10) {
            self.genderModal.isHidden = true
            let row = self.genderPickerView.selectedRow(inComponent: 0)
            self.genderBtn.titleLabel?.text = "\(self.genderArr[row])"
        }
    }
    
    @IBAction func heightBtn(_ sender: UIButton) {
        modalType = .heightModal
        heightPickerView.reloadAllComponents()
        heightPickerView.selectRow(140, inComponent: 0, animated: true)
        UIView.animate(withDuration: 10) {
            self.heightModal.isHidden = false
        }
    }
    
    @IBAction func heightDoneBtn(_ sender: UIButton) {
        UIView.animate(withDuration: 10) {
            self.heightModal.isHidden = true
            let cmValue = self.heightPickerView.selectedRow(inComponent: 0)
            self.heightBtn.titleLabel?.text = "\(self.heightArr[cmValue]) cm"
        }
    }
    
    
    @IBAction func weightBtn(_ sender: UIButton) {
        modalType = .weightModal
        weightPickerView.reloadAllComponents()
        weightPickerView.selectRow(140, inComponent: 0, animated: true)
        UIView.animate(withDuration: 10) {
            self.weightModal.isHidden = false
        }
    }
    @IBAction func weightDoneBtn(_ sender: UIButton) {
        UIView.animate(withDuration: 10) {
            self.weightModal.isHidden = true
            let kgValue = self.weightPickerView.selectedRow(inComponent: 0)
            self.weightBtn.titleLabel?.text = "\(self.weightArr[kgValue]) kg"
        }
    }
    // This function navigates to next Page and check if all the values are entered
    @IBAction func handleNext(_ sender: UIButton) {
        print("handleNext triggered")
        let alertController = UIAlertController(title: "Error", message: "Please enter all values", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        guard let gender = genderBtn.titleLabel?.text , gender != "Not Set" else{
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let height = heightBtn.titleLabel?.text , height != "Not Set" else{
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let weight = weightBtn.titleLabel?.text , weight != "Not Set" else{
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let heightInt = Int(height.split(separator: " ")[0])
        let weightInt = Double(weight.split(separator: " ")[0])
        switch gender {
        case "Male":
            userInstance.setPersonalDetails(gender: .Male, heightInCentimeters: heightInt, weightInKg: weightInt)
            break;
        case "Female":
            userInstance.setPersonalDetails(gender: .Female, heightInCentimeters: heightInt, weightInKg: weightInt)
            break;
        default:
            userInstance.setPersonalDetails(gender: .Others, heightInCentimeters: heightInt, weightInKg: weightInt)
            break;
        }
        performSegue(withIdentifier: "SetGoalIdentifer", sender: self)
        
    }
    
    
    
    
}


// This extension handles all the picker view component
extension PersonalDetailsViewController{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count = 0;
        switch modalType {
        case .genderModal:
            count = genderArr.count
            break;
        case .heightModal:
            count = heightArr.count
            break;
        case .weightModal:
            count = weightArr.count
        }
        //        print("count for row at \(count) \(modalType)")
        return count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str:String
        
        switch modalType {
        case .genderModal:
            str =  genderArr[row]
        case .heightModal:
            str = "\(heightArr[row]) cm"
        case .weightModal:
            str = "\(weightArr[row]) kg"
        }
        
        return str
    }
}
