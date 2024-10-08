import UIKit

class SetGoalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: CustomGoalUIPickerView!
    let arr = Array(3...7)
    
    var userInstance = UserData.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: false)
        print(userInstance.user.personalDetails)
    }
    
    var selectedGoal = 3
    @IBAction func handleNext(_ sender: UIButton) {
        print("Clicked")
        print("selected Goal triggered \(selectedGoal)")
        userInstance.user.goalDetails.weeklyGoal = selectedGoal
        performSegue(withIdentifier: "FitnesGoalIdentifer", sender: self)
    }
}

// This extension handles pickerView component
extension SetGoalViewController{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arr.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 25)
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = .primary
        }
        pickerLabel?.text = "\(arr[row])"
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let changeSelectedRow = pickerView.view(forRow: row, forComponent: component) as? UILabel{
            print(changeSelectedRow)
        }
        else{
            print("Error")
        }
        let selectedNum = arr[row]
        print(selectedNum)
        selectedGoal = selectedNum
    }
}
