//
//  UserAccountDataModel.swift
//  VisualFit
//
//  Created by student on 20/04/24.
//

import UIKit

enum Gender2{
    case Female
    case Male
    case Others
}
struct Height2{
    
    var heightInCentimeters : Int?
    var heightInFeet : Int?
}

struct Weight2{
    var weightInKg : Int?
    var weightInPounds : Int?
}

struct User2{
    
    let appleID : String
    var firstName : String
    var lastName : String
    var gender : Gender2
    var height : Height2
    var weight : Weight2
    var username : String
    var xp : Int?
    var currentStreak : Int
    var bestStreak : Int
    var badgesEarned : [Badge2]
    var profilePhoto : UIImage
    var friends : [User2]
}

struct Badge2{
    
    let days : Int
    var isLocked : Bool
}

