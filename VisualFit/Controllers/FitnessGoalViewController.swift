import UIKit

class FitnessGoalViewController: UIViewController  {
    @IBOutlet weak var pickerView: UIPickerView!
    
    let arr = Array(0...50)
    var rotatingAngle : CGFloat!
    
    @IBOutlet weak var firstImgView: FirstImgView!
    
    @IBOutlet weak var secondImgView: SecndImgView!
    
    @IBOutlet weak var skioBtn: UIButton!
    var selectedNum : Int = 4;
    var userInstance = UserData.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        rotatingAngle = -90 * (.pi/180)
        overrideUserInterfaceStyle = .dark
        pickerView.transform = CGAffineTransform(rotationAngle: rotatingAngle)
        pickerView.frame = CGRect(x: -100, y: pickerView.frame.origin.y + 20, width: view.frame.width+200, height: 250)
        pickerView.backgroundColor = .clear
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(4, inComponent: 0, animated: false)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFirstImgViewTap), name: Notification.Name("FirstImgViewTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSecondImgViewTap), name: Notification.Name("SecondImgViewTapped"), object: nil)
    }
    
    @objc func handleFirstImgViewTap() {
        // Handle tap gesture on FirstImgView
        secondImgView.updateBackgroundColor(color: .darkGray,isSelected: false)
        firstImgView.updateBackgroundColor(color: .primary,isSelected: true)
        print("FirstImgView tapped")
        pickerView.selectRow(4, inComponent: 0, animated: false)
        self.skioBtn.isUserInteractionEnabled = true
        self.skioBtn.isHidden = false
    }
    
    @objc func handleSecondImgViewTap() {
        // Handle tap gesture on SecondImgView
        changeGoalUI()
    }
    
    func changeGoalUI(){
        secondImgView.updateBackgroundColor(color: .primary,isSelected: true)
        firstImgView.updateBackgroundColor(color: .darkGray,isSelected: false)
        self.selectedNum = 4
        pickerView.selectRow(4, inComponent: 0, animated: false)
        self.skioBtn.isUserInteractionEnabled = false
        self.skioBtn.isHidden = true
    }
    
    @IBAction func handleSkip(_ sender: UIButton) {
        if(firstImgView.isSelected){
            userInstance.user.goalDetails.fatLoss = 0
            changeGoalUI()
        }
    }
    
    func handleTabBarChange(){
        print("button pressed")
        UserDefaults.standard.set("userState", forKey: "fitLatestUser")
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func handleSubmit(_ sender: UIButton) {
        print("weekly goal details \(userInstance.user.goalDetails.weeklyGoal)")
        if(firstImgView.isSelected){
            userInstance.user.goalDetails.fatLoss = self.selectedNum
            changeGoalUI()
        }
        else{
            userInstance.user.goalDetails.muscleGain = self.selectedNum
            //performSegue(withIdentifier: "startJourneyIdentifier", sender: self)
            handleTabBarChange()
        }
        
    }
}

// This extension handles all function of pickerView
extension FitnessGoalViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arr.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(arr[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNum = arr[row]
        
        print("Selected number is \(selectedNum)")
        
        let selectedRowView = pickerView.view(forRow: row, forComponent: component)
        
        if let label = selectedRowView as? UILabel {
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = UIColor.red
        }
        self.selectedNum = selectedNum
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100    }
    
    func createStick(width: CGFloat, height: CGFloat) -> UILabel {
        let stick = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 1))
        stick.transform = CGAffineTransform(rotationAngle: rotatingAngle * -1)
        stick.textColor = .white
        stick.backgroundColor = .primary
        stick.textAlignment = .center
        stick.textColor = .primary
        stick.font = .systemFont(ofSize: 50, weight: .bold)
        return stick
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        view.transform = CGAffineTransform(rotationAngle: rotatingAngle * -1)
        
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: 100, height: 55))
        label.text = "\(arr[row])"
        label.textColor = .white
        label.textAlignment = .center
        label.textColor = .primary
        label.font = .systemFont(ofSize: 50, weight: .bold)
        view.addSubview(label)
        
        let stickWidth: CGFloat = 60
        let stickHeight: CGFloat = 5
        
        let stick = createStick(width: stickWidth+20, height: stickHeight)
        let stickLeft = createStick(width: stickWidth * 0.67, height: stickHeight)
        let stickRight = createStick(width: stickWidth * 0.67, height: stickHeight)
        
        let horizontalStack = UIStackView(frame: CGRect(x: 20, y: 100, width: view.frame.width, height: stickHeight))
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 2
        horizontalStack.addArrangedSubview(stickLeft)
        horizontalStack.addArrangedSubview(stickLeft)
        horizontalStack.addArrangedSubview(stick)
        horizontalStack.addArrangedSubview(stickRight)
        horizontalStack.addArrangedSubview(stickRight)
        
        view.addSubview(horizontalStack)
        
        return view
    }
}
