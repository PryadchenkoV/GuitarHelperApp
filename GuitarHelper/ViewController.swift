//
//  ViewController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SendNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func SendNotification(){
        let calendar = NSCalendar.currentCalendar()
        let calComp = NSDateComponents()
        calComp.hour = 20
        calComp.minute = 0
        calComp.second = 0
        calendar.timeZone = NSTimeZone.defaultTimeZone()
        var dataForce = calendar.dateFromComponents(calComp)
        
        let notification = UILocalNotification()
        notification.alertTitle = "Came on!"
        notification.alertBody = "Let's play GutarHelper!"
        notification.alertAction = "Let's Go"
        notification.fireDate = dataForce
        notification.repeatInterval = .Day
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    
}

