//
//  UserModel.swift
//  VisualFit
//
//  Created by Goyal Harsh on 24/04/24.
//

import Foundation
import UIKit

struct User{
    var id : String
    var avatar : String
    var fullName: String
    var username : String
    var email: String
    var personalDetails : PersonalDetails
    var goalDetails : GoalDetails
    var currentStreak : Int
    var bestStreak : Int
    var friendsCount: Int
    var todayImage : UIImage?
    var todayTransformedImage : UIImage?
    
    init(){
        self.id = "8facd2929858ffcc"
        self.avatar = ""
        self.fullName = "Harsh"
        self.username = "harsh9539"
        self.email = "goyal@gmail.com"
        self.personalDetails = PersonalDetails()
        self.goalDetails = GoalDetails()
        self.friendsCount = Int.random(in: 3...15)
        self.currentStreak = Int.random(in: 1...10)
        self.bestStreak = 10
        self.todayImage = UIImage(named: "harsh-before")
        self.todayTransformedImage = UIImage(named: "harsh-after")
    }
}


enum Gender{
    case Male
    case Female
    case Others
}

struct PersonalDetails {
    var gender : Gender?
    var height : Height?
    var weight : Weight?
    
    init() {
        self.gender = .Male
        self.height?.heightInCentimeters = 168
        self.weight?.weightInKg = 78
    }
    
}

struct GoalDetails {
    var weeklyGoal : Int
    var muscleGain : Int?
    var fatLoss : Int?
    
    init(){
        self.weeklyGoal = 4
        self.muscleGain = 4
        self.fatLoss = 4
    }
    
}

struct Height {
    var heightInCentimeters: Int?  = 0
    
    var heightInFeet: Int? {
        get {
            if let centimeters = heightInCentimeters {
                return centimeters / 30
            }
            return nil
        }
        set {
            if let newValue = newValue {
                heightInCentimeters = newValue * 30
            } else {
                heightInCentimeters = nil
            }
        }
    }
}
struct Weight {
    var weightInKg: Double?  = 0
    
    var weightInPounds: Double? {
        get {
            if let kg = weightInKg {
                return kg * 2.0
            }
            return nil
        }
        set {
            if let newValue = newValue {
                weightInKg = newValue / 2.0
            } else {
                weightInKg = nil
            }
        }
    }
}


class UserData {
    var user: User
    private static var shared: UserData = UserData()
    
    static func getInstance() -> UserData {
        return shared
    }
    
    private init() {
        self.user = User()
        self.user.personalDetails = PersonalDetails()
        self.user.personalDetails.height = Height()
        self.user.personalDetails.weight = Weight()
    }
    
    func setPersonalDetails(gender: Gender?, heightInCentimeters: Int?, weightInKg: Double?) {
        self.user.personalDetails.gender = gender
        self.user.personalDetails.height?.heightInCentimeters = heightInCentimeters!
        self.user.personalDetails.weight?.weightInKg = weightInKg!
        print(user.personalDetails.height?.heightInFeet ?? 0)
    }
    func setGoalDetails(weeklyGoal: Int, muscleGain: Int?, fatLoss: Int?) {
        user.goalDetails.weeklyGoal = weeklyGoal
        user.goalDetails.muscleGain = muscleGain
        user.goalDetails.fatLoss = fatLoss
    }
    
    func setUserDetails(id: String, avatar: String, fullName: String, email: String) {
        user.id = id
        user.avatar = avatar
        user.fullName = fullName
        user.email = email
    }
    
    func setStreakDetails(currentStreak: Int, bestStreak: Int) {
        user.currentStreak = currentStreak
        user.bestStreak = bestStreak
    }
}
