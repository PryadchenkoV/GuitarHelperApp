//
//  MetronomController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit


let kPickerFirstValue = 40
let kPickerFinalValue = 208

class MetronomController: WKInterfaceController {

    @IBOutlet var pickerSpeed: WKInterfacePicker!
    @IBOutlet var buttonStart: WKInterfaceButton!
    
    var indexPicker = 0
    
    var beat = NSTimer()
    
    
    var flagStart = true
    
    var player: WKAudioFilePlayer!
    var items: [String]! = nil
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
        var pickerItems: [WKPickerItem] = []
        for i in kPickerFirstValue...kPickerFinalValue {
            let item = WKPickerItem()
            item.title = "\(i)"
            pickerItems.append(item)
        }
        
        
        self.pickerSpeed.setItems(pickerItems)
        // Configure interface objects here.
    }
    
    @IBAction func pickerIndex(value: Int) {
        if value > 0 {
            indexPicker = value + kPickerFirstValue
        }
        else {
            indexPicker = kPickerFirstValue
        }
    }

    
    @IBAction func buttonStartPush() {
        self.presentControllerWithName("metronomController", context: indexPicker)

        
    }


}
