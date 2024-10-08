//
//  StreakCalenderViewController.swift
//  VisualFit
//
//  Created by student on 26/04/24.
//
import UIKit
import FSCalendar





class StreakCalenderViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    var eventsDictionary: [String: [String]] = [:]
    let calendarInstance = CalendarData.getInstance()
    @IBOutlet weak var stepsCount: UILabel!
    @IBOutlet weak var caloriesCount: UILabel!
    @IBOutlet weak var isStreakImg: UIImageView!
    @IBOutlet weak var mainImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        updateUI(forDate: Date())
    }
    
    // MARK: - FSCalendarDelegate
    
    func updateUI(forDate date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDateString = formatter.string(from: date)

        if let matchedCalendarModel = CalendarData.getInstance().calendarData.first(where: { calendarModel in
            let calendarModelDateString = formatter.string(from: calendarModel.date)
            return calendarModelDateString == selectedDateString
        }) {
            print("Match found: Date - \(selectedDateString), Steps - \(matchedCalendarModel.steps), Calories - \(matchedCalendarModel.calories), Is Streak - \(matchedCalendarModel.isStreak)")
            stepsCount.text = "\(matchedCalendarModel.steps)"
            caloriesCount.text = "\(matchedCalendarModel.calories)"
            mainImg.image = matchedCalendarModel.image
            isStreakImg.image = matchedCalendarModel.isStreak ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")
            isStreakImg.tintColor = matchedCalendarModel.isStreak ? .green : .red
        } else {
            print("No match found for date: \(selectedDateString)")
            stepsCount.text = "0"
            caloriesCount.text = "0"
            mainImg.image = UIImage(systemName: "photo")
            isStreakImg.image = UIImage(systemName: "xmark.circle")
            isStreakImg.tintColor = .red
        }
    }

    
    // Called when a date is selected
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        updateUI(forDate: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        // Find the CalendarModel for the given date
        if let matchedCalendarModel = CalendarData.getInstance().calendarData.first(where: { calendarModel in
            let calendarModelDateString = formatter.string(from: calendarModel.date)
            return calendarModelDateString == dateString
        }) {
            // If isStreak is true, return the streak color
            if matchedCalendarModel.isStreak {
                return UIColor.green.withAlphaComponent(0.5) // You can change this to your desired color
            } else {
                return UIColor.red.withAlphaComponent(0.4)
            }
        }
        
        // Return nil if no match found or isStreak is false
        return nil
    }
    
    
}
