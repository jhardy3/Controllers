//
//  NotificationController.swift
//  LocalNotif
//
//  Created by Jake Hardy on 4/12/16.
//  Copyright © 2016 Jake Hardy. All rights reserved.
//

import Foundation
import UIKit

class NotificationController {
    
    static func createNotification(alertBody: String, alertTitle: String, timeIntervalInSeconds: NSTimeInterval) {
        let notif =  UILocalNotification()
        notif.alertBody = alertBody
        notif.alertTitle = alertTitle
        notif.fireDate = NSDate().dateByAddingTimeInterval(timeIntervalInSeconds)
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().scheduleLocalNotification(notif)
    }
    
    static func addObserverForNotification(observer: AnyObject, selector: Selector, name: String) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: name, object: nil)
    }
    
    static func registerNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
    
        application.registerUserNotificationSettings(notificationSettings)
    }
    
}