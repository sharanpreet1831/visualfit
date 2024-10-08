//
//  AppDelegate.swift
//  VisualFit
//
//  Created by Goyal Harsh on 10/04/24.
//

import UIKit

extension UIColor {
    static var random: UIColor{
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }
    static var primary: UIColor {
        let red = CGFloat(239)
        let green = CGFloat(240)
        let blue = CGFloat(0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    static var primaryLight: UIColor {
        let red = CGFloat(95)
        let green = CGFloat(95)
        let blue = CGFloat(36)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    static var pinkTransform: UIColor {
        let red = CGFloat(199)
        let green = CGFloat(115)
        let blue = CGFloat(234)
        return UIColor(red: red, green: green, blue: blue, alpha: 0.9)
    }
    
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        var letUser = UserDefaults.standard.object(forKey: "fitLatestUser")
        print(letUser)
        self.window = window
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @objc func done() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
}

