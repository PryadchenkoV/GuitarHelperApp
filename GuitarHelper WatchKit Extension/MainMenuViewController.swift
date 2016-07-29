//
//  MainMenuViewController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation


class MainMenuViewController: WKInterfaceController {

    @IBOutlet var imageMetro: WKInterfaceImage!
    
    var flagTimer = true
    var timer = 0
    var beat = NSTimer()
    
    @IBOutlet var lableBeat: WKInterfaceLabel!
    var imageLeft : UIImage = UIImage(named:"metro_left")!
    var imageRight : UIImage = UIImage(named:"metro_right")!
    
    override func awakeWithContext(context: AnyObject?) {
        
        super.awakeWithContext(context)
        if let value = context as? Int {
            timer = value
        }
        let beatPylse = 60.0/Double(timer)
        beat.invalidate()
        beat = NSTimer.scheduledTimerWithTimeInterval(beatPylse, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        lableBeat.setText("\(Int(timer)) bpm")
        
        
        // Configure interface objects here.
    }
    
    func timerAction() {
        if flagTimer {
            imageMetro.setImage(imageLeft)
            flagTimer = false
        }
        else {
            imageMetro.setImage(imageRight)
            flagTimer = true
        }
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
