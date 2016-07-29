//
//  SecControlMethronome.swift
//  GuitarHelper
//
//  Created by Danya on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation

var vFlagMetronom = false
var vSpeedMetronomeValue = 0

let kBeatRateLinePList = "BPM"

class SecControlMethronome: WKInterfaceController {

    @IBOutlet var myPicker: WKInterfacePicker!
   
    @IBOutlet var mySwitchOutlet: WKInterfaceSwitch!
    
    @IBAction func mySwitch(value: Bool) {
        if value {
            myPicker.setEnabled(true)
            myPicker.setAlpha(1)
            vFlagMetronom = true
            
            
        }
        else{
            myPicker.setEnabled(false)
            myPicker.setAlpha(0)
            vFlagMetronom = false
            vSpeedMetronomeValue = 0
        }

    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        print(chooseSongIndex!)
        myPicker.setAlpha(0)
       
        var pickerItems: [WKPickerItem] = []
        for i in 10...kPickerFinalValue {
            let item = WKPickerItem()
            item.title = "\(i)"
            pickerItems.append(item)
        }
        
        
        myPicker.setItems(pickerItems)
        myPicker.setSelectedItemIndex((myDict![String(chooseSongIndex!)]![kBeatRateLinePList]!)! as! Int - 10)
        
    
    }
    
    @IBAction func pickerAction(value: Int) {
        vSpeedMetronomeValue = value + 10
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
