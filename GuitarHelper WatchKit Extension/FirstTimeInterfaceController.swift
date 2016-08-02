//
//  FirstTimeInterfaceController.swift
//  GuitarHelper
//
//  Created by Danya on 01.08.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation

let names = ["ChooseSong","Metronome","Library","About"]
class FirstTimeInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    
    @IBAction func buttonPressed() {
        self.presentControllerWithNames(names, contexts: nil)
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
