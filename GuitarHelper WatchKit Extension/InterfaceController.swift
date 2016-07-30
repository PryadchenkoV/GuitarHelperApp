//
//  interfaceController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

//
//  InterfaceController.swift
//  GuitarHelper WatchKit Extension
//
//  Created by Ivan Pryadchenko on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation


let kAudioFileNameLinePList = "AudioFileName"
var chooseSongIndex:Int?

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var buttonListen: WKInterfaceButton!
    
    let names = ["Chords","Tabs"]
    
    //let nameS : [String] = ["nirvana_teen_spirit","kino_aljuminievie_ogurci", "nirvana_about_a_girl"]
    
    @IBOutlet var myTable: WKInterfaceTable!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let newContext = context{
            chooseSongIndex = newContext as? Int
        }
        loadTableData()
    }
    
    private func  loadTableData(){
        myTable.setNumberOfRows(names.count, withRowType: "CordsRowController")
        
        for (index, nameT) in names.enumerate(){
            let row = myTable.rowControllerAtIndex(index) as! CordsRowControl
            row.myLable.setText(nameT)
        }
    }
    func showPopup(value: Int) -> Bool {
        
        let action1 = WKAlertAction(title: "Yeah!", style: .Default) { () -> Void in
            self.presentControllerWithName("chordsChange\(value)", context: chooseSongIndex)
        }
        
        let action2 = WKAlertAction(title: "No:(", style: .Cancel) { () -> Void in
            
            return false
        }
        
        
        presentAlertControllerWithTitle("🤘", message: "Are you ready to... \n!ROCK!", preferredStyle: .ActionSheet, actions: [action1, action2])
        
        return false
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        print(rowIndex)
        showPopup(rowIndex)
    }

    @IBAction func buttonListenPush() {
        
        //let urls = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(nameS[chooseSongIndex!], ofType: "mp3")!)
        let urls = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource((myDict![String(chooseSongIndex!)]![kAudioFileNameLinePList]!)! as? String, ofType: "mp3")!)
        self.presentMediaPlayerControllerWithURL(urls, options: nil, completion: { (didPlayToEnd, endTime, error) -> Void in
        })

    }
    
}

