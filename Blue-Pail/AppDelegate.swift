//
//  AppDelegate.swift
//  Blue-Pail
//
//  Created by David Sadler on 5/6/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //alwaysFirstLaunch()
        onFirstLaunch()
        
        return true
    }
    
    // MARK: - First Launch Methods
    
    // CHECK IF THESE ARE PROPERLY CONFIGURED
    private func onFirstLaunch() {
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: Keys.FirstLaunchKey)
        if firstLaunch.isFirstLaunch {
            CreateDataFactory.createData()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingPageViewController") as! OnboardingPageViewController
            self.window?.rootViewController = onboardingViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    // MARK: userNotifcationCenter willPresentNotification
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

