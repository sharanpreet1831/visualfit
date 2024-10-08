//
//  EditPersonalDetailsTableViewController.swift
//  VisualFit
//
//  Created by student on 01/05/24.
//

import UIKit

// creating arrays for different picker views
let genderArray : [String] = ["Male", "Female", "Others"]
let weeklyGoalArray  : [Int] = Array(3...7)
let heightArray : [Int] = Array(1...300)
let fatMuscleArr = Array(1...50)

class EditPersonalDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var dateOfBirthDetailLabel: UILabel!
    
    @IBOutlet weak var genderDetailLabel: UILabel!
    
    @IBOutlet weak var heightDetailLabel: UILabel!
    
    @IBOutlet weak var weightDetailLabel: UILabel!
    
    @IBOutlet weak var weeklyGoalDetailLabel: UILabel!
    var weightArray = [Any]()
    
    @IBOutlet weak var fatLossDetailLabel: UILabel!
    
    @IBOutlet weak var muscleGainDetailLabel: UILabel!
    
    
    
    @IBOutlet weak var saveButton: UINavigationItem!
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBOutlet weak var heightPickerView: UIPickerView!
    
    
    @IBOutlet weak var weightPickerView: UIPickerView!
    
    
    @IBOutlet weak var weeklyGoalPickerView: UIPickerView!
    
    
    @IBOutlet weak var fatLossPickerView: UIPickerView!
    
    @IBOutlet weak var muscleGainPickerView: UIPickerView!
    
    
    // variables to toggle picker's visibility
    
    var isDatePickerVisible : Bool = false {
        didSet{
            datePickerView.isHidden = !isDatePickerVisible
        }
    }
    var isGenderPickerVisible : Bool = false {
        didSet{
            genderPickerView.isHidden = !isGenderPickerVisible
        }
    }
    var isHeightPickerVisible : Bool = false {
        didSet{
            heightPickerView.isHidden = !isHeightPickerVisible
        }
    }
    var isWeightPickerVisible : Bool = false {
        didSet{
            weightPickerView.isHidden = !isWeightPickerVisible
        }
    }
    var isWeeklyGoalPickerVisible : Bool = false {
        didSet{
            weeklyGoalPickerView.isHidden = !isWeeklyGoalPickerVisible
        }
    }
    var isFatLossPickerVisible : Bool = false {
        didSet{
            fatLossPickerView.isHidden = !isFatLossPickerVisible
        }
    }
    var isMuscleGainPickerVisible : Bool = false {
        didSet{
            muscleGainPickerView.isHidden = !isMuscleGainPickerVisible
        }
    }
    
    var userDummyData = HealthDetailData.getInstance().userDetails
    
    //indexPaths
    var dateOfBirthIndexPath : IndexPath = IndexPath(row: 0, section: 0)
    var dateOfBirthPickerIndexPath : IndexPath = IndexPath(row: 1, section: 0)
    var genderIndexPath : IndexPath = IndexPath(row: 2, section: 0)
    var genderPickerIndexPath : IndexPath = IndexPath(row: 3, section: 0)
    var heightIndexPath : IndexPath = IndexPath(row: 4, section: 0)
    var heightPickerIndexPath : IndexPath = IndexPath(row: 5, section: 0)
    var weightIndexPath : IndexPath = IndexPath(row: 6, section: 0)
    var weightPickerIndexPath : IndexPath = IndexPath(row: 7, section: 0)
    var weeklyGoalIndexPath : IndexPath = IndexPath(row: 8, section: 0)
    var weeklyGoalPickerIndexPath : IndexPath = IndexPath(row: 9, section: 0)
    var fatLossIndexPath : IndexPath = IndexPath(row: 10, section: 0)
    var fatLossPickerIndexPath : IndexPath = IndexPath(row: 11, section: 0)
    var muscleGainIndexPath : IndexPath = IndexPath(row: 12, section: 0)
    var muscleGainPickerIndexPath : IndexPath = IndexPath(row: 13, section: 0)
    
    var userInstance = UserData.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        dateOfBirthDetailLabel.text = userDummyData.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
        genderDetailLabel.text = "\(userInstance.user.personalDetails.gender!)"
        if let height = userInstance.user.personalDetails.height?.heightInCentimeters{
            heightDetailLabel.text = "\(height) cm"
        }
        if let weight = userInstance.user.personalDetails.weight?.weightInKg{
            weightDetailLabel.text = "\(weight) kg"
        }
        if let gender = userInstance.user.personalDetails.gender{
            genderDetailLabel.text = "\(gender)"
        }
        weeklyGoalDetailLabel.text = "\(userInstance.user.goalDetails.weeklyGoal) days"
        if let fatLossWeight = userInstance.user.goalDetails.fatLoss{
            fatLossDetailLabel.text = "\(fatLossWeight) kg"
        }
        if let muscleGainWeight = userInstance.user.goalDetails.muscleGain{
            muscleGainDetailLabel.text = "\(muscleGainWeight) kg"
        }
        datePickerView.date = userDummyData.dateOfBirth
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.selectRow(0, inComponent: 0, animated: true)
        heightPickerView.delegate = self
        heightPickerView.dataSource = self
        let findHeightIndex = heightArray.firstIndex(of: userInstance.user.personalDetails.height?.heightInCentimeters ?? 1)
        heightPickerView.selectRow(165, inComponent: 0, animated: true)
        weightPickerView.delegate = self
        weightPickerView.dataSource = self
        weightPickerView.selectRow(Int(userInstance.user.personalDetails.weight?.weightInKg ?? 1), inComponent: 0, animated: true)
        weeklyGoalPickerView.delegate = self
        weeklyGoalPickerView.dataSource = self
        weeklyGoalPickerView.selectRow(userInstance.user.goalDetails.weeklyGoal, inComponent: 0, animated: true)
        fatLossPickerView.delegate = self
        fatLossPickerView.dataSource = self
        fatLossPickerView.selectRow(Int(userInstance.user.goalDetails.fatLoss!), inComponent: 0, animated: true)
        muscleGainPickerView.delegate = self
        muscleGainPickerView.dataSource = self
        muscleGainPickerView.selectRow(Int(userInstance.user.goalDetails.muscleGain!), inComponent: 0, animated: true)
        for number in stride(from: 0.5, through: 655.5, by: 0.5) {
            if floor(number) == number {
                weightArray.append(Int(number))
            } else {
                weightArray.append(number)
            }
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        updateUserData()
    }
    
    
    //updating the detail of all labels with user's data by default
    func updateUserData(){
        if let updatedHeightString = heightDetailLabel.text{
            let updatedHeight = trimStringForInt(updatedHeightString)
            userInstance.user.personalDetails.height?.heightInCentimeters = updatedHeight
        }
        if let updatedWeightString = weightDetailLabel.text{
            let updatedWeight = trimStringForDouble(updatedWeightString)
            userInstance.user.personalDetails.weight?.weightInKg = updatedWeight
        }
        if let updatedGenderString = genderDetailLabel.text{
            if updatedGenderString == "Female"{
                userInstance.user.personalDetails.gender = .Female
            } else if updatedGenderString == "Male"{
                userInstance.user.personalDetails.gender = .Male
            } else {
                userInstance.user.personalDetails.gender = .Others
            }
        }
        if let updatedWeeklyGoalString = weeklyGoalDetailLabel.text{
            userInstance.user.goalDetails.weeklyGoal = trimStringForInt(updatedWeeklyGoalString)
        }
        if let updatedFatLossString = fatLossDetailLabel.text{
            userInstance.user.goalDetails.fatLoss = trimStringForInt(updatedFatLossString)
        }
        if let updatedMuscleGain = muscleGainDetailLabel.text{
            userInstance.user.goalDetails.muscleGain = trimStringForInt(updatedMuscleGain)
        }
        tableView.reloadData()
    }
    // functions to get integer values from corresponding label
    func trimStringForInt(_ string: String) ->Int{
        return Int(string.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))!
    }
    func trimStringForDouble(_ string: String) ->Double{
        return Double(string.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateUserData()
    }
    
    //updating the details according to the value set in the picker view
    func updateUI(){
        
        dateOfBirthDetailLabel.text = datePickerView.date.formatted(date: .abbreviated, time: .omitted)
        genderDetailLabel.text = genderArray[genderPickerView.selectedRow(inComponent: 0)]
        heightDetailLabel.text = "\(heightArray[heightPickerView.selectedRow(inComponent: 0)]) cm"
        weightDetailLabel.text = "\(weightArray[weightPickerView.selectedRow(inComponent: 0)]) kg"
        weeklyGoalDetailLabel.text = "\(weeklyGoalArray[weeklyGoalPickerView.selectedRow(inComponent: 0)]) days"
        fatLossDetailLabel.text = "\(fatMuscleArr[fatLossPickerView.selectedRow(inComponent: 0)]) kg"
        muscleGainDetailLabel.text = "\(fatMuscleArr[muscleGainPickerView.selectedRow(inComponent: 0)]) kg"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 14
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath == dateOfBirthIndexPath){
            isDatePickerVisible.toggle()
        }
        else if(indexPath == genderIndexPath){
            genderPickerView.reloadAllComponents()
            isGenderPickerVisible.toggle()
        }
        else if(indexPath == heightIndexPath){
            heightPickerView.reloadAllComponents()
            isHeightPickerVisible.toggle()
        }
        else if(indexPath == weightIndexPath){
            weightPickerView.reloadAllComponents()
            isWeightPickerVisible.toggle()
        }
        else if(indexPath == weeklyGoalIndexPath){
            weeklyGoalPickerView.reloadAllComponents()
            isWeeklyGoalPickerVisible.toggle()
        }
        else if(indexPath == fatLossIndexPath){
            fatLossPickerView.reloadAllComponents()
            isFatLossPickerVisible.toggle()
        }
        else if(indexPath == muscleGainIndexPath){
            muscleGainPickerView.reloadAllComponents()
            isMuscleGainPickerVisible.toggle()
        }
        else{
            return
        }
        updateUI()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    //setting height to zero for picker view cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case dateOfBirthPickerIndexPath where isDatePickerVisible == false:
            return 0
        case genderPickerIndexPath where isGenderPickerVisible == false:
            return 0
        case heightPickerIndexPath where isHeightPickerVisible == false:
            return 0
        case weightPickerIndexPath where isWeightPickerVisible == false:
            return 0
        case weeklyGoalPickerIndexPath where isWeeklyGoalPickerVisible == false:
            return 0
        case fatLossPickerIndexPath where isFatLossPickerVisible == false:
            return 0
        case muscleGainPickerIndexPath where isMuscleGainPickerVisible == false:
            return 0
        default :
            return UITableView.automaticDimension
        }
    }
    // setting estimated height for picker view cells
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case dateOfBirthPickerIndexPath :
            return 190
        case genderPickerIndexPath :
            return 100
        case heightPickerIndexPath:
            return 190
        case weightPickerIndexPath :
            return 190
        case weeklyGoalPickerIndexPath:
            return 190
        case fatLossPickerIndexPath:
            return 190
        case muscleGainPickerIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
}


// this extension handles all the function of pickerView
extension EditPersonalDetailsTableViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
        case genderPickerView:
            return genderArray.count
        case weeklyGoalPickerView:
            return weeklyGoalArray.count
        case heightPickerView:
            return heightArray.count
        case weightPickerView:
            return weightArray.count
        case fatLossPickerView:
            return fatMuscleArr.count
        case muscleGainPickerView:
            return fatMuscleArr.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str:String
        
        switch pickerView {
        case genderPickerView:
            str =  genderArray[row]
        case heightPickerView:
            str = "\(heightArray[row]) cm"
        case weightPickerView:
            str = "\(weightArray[row]) kg"
        case weeklyGoalPickerView:
            str = "\(weeklyGoalArray[row])"
        case fatLossPickerView:
            str = "\(fatMuscleArr[row]) kg"
        case muscleGainPickerView:
            str = "\(fatMuscleArr[row]) kg"
        default:
            str = ""
            
        }
        return str
    }
}
