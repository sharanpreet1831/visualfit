//
//  CalendarModel.swift
//  VisualFit
//
//  Created by Goyal Harsh on 06/05/24.
//

import Foundation
import UIKit

struct CalendarModel{
    var date : Date
    var steps : Int
    var calories : Int
    var isStreak : Bool
    var image : UIImage
    
    init(){
        self.date = Date()
        self.steps = 0
        self.calories = 0
        self.isStreak = false
        self.image = UIImage(systemName: "photo")!
    }
    
    init(date: Date, steps: Int, calories: Int, isStreak: Bool, image: UIImage) {
        self.date = date
        self.steps = steps
        self.calories = calories
        self.isStreak = isStreak
        self.image = image
    }
}


class CalendarData {
    
    var calendarData : [CalendarModel] = []
    private static let shared : CalendarData = CalendarData()
    
    static func getInstance() -> CalendarData{
        return shared
    }
    
    init(){
        var currentDate = Date()
        for i in 0..<30 {
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            
            let randomSteps = Int.random(in: 1000...9999)
            let randomCalories = Int.random(in: 100...500)
            let isStreak = Bool.random()
            let randomImage = i % 2 == 0 ?  UIImage(named: "harsh-before")! : UIImage(named: "harsh-after")!
            
            let calendarModel = CalendarModel(date: currentDate, steps: randomSteps, calories: randomCalories, isStreak: isStreak, image: randomImage)
            calendarData.append(calendarModel)
        }
    }
    
    
    
    
}
