//
//  MainScreen.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 11.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//


import WatchKit
import Foundation

var myDict: NSDictionary?

let kNameOfPList = "SongPList"
let kNameLinePList = "Name"
let kAuthorLinePList = "Author"

class MainScreen: WKInterfaceController {
    
    let arrView = ["secView1","secView2","secView3"]
    
    @IBOutlet var songTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if !defaults.boolForKey("firstview") {
            defaults.setBool(true, forKey: "firstview")
            self.presentControllerWithName("FirstTimeController", context: nil)
        }
        let path = NSBundle.mainBundle().pathForResource(kNameOfPList, ofType: "plist")
        myDict = NSDictionary(contentsOfFile: path!)
        
        loadList()

    }
    
    func loadList()  {
        songTable.setNumberOfRows((myDict?.count)!, withRowType: "MainScreenSongList")
        for index in 0...(myDict?.count)! - 1{
            let row = songTable.rowControllerAtIndex(index) as! MainScreenSongList
            row.lableSongText.setText((myDict![String(index)]![kNameLinePList]!)! as? String)
            row.lableAuthorText.setText((myDict![String(index)]![kAuthorLinePList]!)! as? String)

        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        self.presentControllerWithNames(arrView, contexts: [rowIndex])
    }
    

}


