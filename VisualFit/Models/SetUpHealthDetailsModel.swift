//
//  SetUpHealthDetailsModel.swift
//  VisualFit
//
//  Created by student on 01/05/24.
//


import UIKit

struct HealthDetail{
    var dateOfBirth : Date
    var Gender : Gender
    var height : Height
    var weight : Weight
    var weeklyGoal : Int
    var fatLossMass : Weight
    var muscleGainMass : Weight
    
}
class HealthDetailData {
    var  userDetails : HealthDetail
    private static let healthDetailInstance : HealthDetailData = HealthDetailData()
    
    static func getInstance() -> HealthDetailData{
        return healthDetailInstance
    }
    
    func getHealthData() -> HealthDetail{
        return userDetails
    }
    
    private init() {
        
        let health_data: HealthDetail =
        HealthDetail(
            dateOfBirth : Calendar.current.startOfDay(
                for: Date()
            ),
            Gender: .Male,
            height: Height(
                heightInCentimeters: 168
            ),
            weight: Weight(
                weightInKg: 67
            ),
            weeklyGoal: 5,
            fatLossMass: Weight(
                weightInKg: 4
            ),
            muscleGainMass: Weight(
                weightInKg: 6
            )
        )
        
        userDetails = health_data
        
    }
    
    
}
