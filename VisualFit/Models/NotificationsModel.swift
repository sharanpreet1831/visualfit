//
//  NotificationsModel.swift
//  VisualFit
//
//  Created by student on 03/05/24.
//

import UIKit

struct UserNotification{
    
    var isPeerActivityNotificationOn : Bool
    var isGoalCompletionNotificationOn : Bool
    var isTransformationFeedNotificationOn : Bool
}

class UserNotificationData{
    var notificationSelection :UserNotification
    private static var shared: UserNotificationData = UserNotificationData()
    
    static func getInstance() -> UserNotificationData {
        return shared
    }
    
    private init(){
        self.notificationSelection = UserNotification(isPeerActivityNotificationOn: true, isGoalCompletionNotificationOn: true, isTransformationFeedNotificationOn: true)
    }
}
