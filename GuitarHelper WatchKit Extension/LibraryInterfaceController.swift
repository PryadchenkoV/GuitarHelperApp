//
//  LibraryInterfaceController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 13.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation


class LibraryInterfaceController: WKInterfaceController {

    var chordSet: Set<String>?
    var bufArr:[String] = []

    
    @IBOutlet var tableLibrery: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        loadList()
        // Configure interface objects here.
    }

    func loadList()  {
        
        for j in 0..<myDict!.count {
            for i in 0..<myDict![String(j)]![kChordArrayLinePList]!!.count {
                let chord = myDict![String(j)]![kChordArrayLinePList]!![String(i)]!!
                let chordValue: String = chord[kChordLinePList] as! String
                bufArr.append(chordValue)
            }
        }
        chordSet = Set(bufArr)
        print(chordSet!)
        print((chordSet?.count)!)
        
        
        
        tableLibrery.setNumberOfRows((chordSet?.count)!, withRowType: "LibraryTableList")
        for index in 0...(chordSet?.count)! - 1{
            let row = tableLibrery.rowControllerAtIndex(index) as! LibraryTableList
            row.lableChordName.setText(chordSet![(chordSet?.startIndex.advancedBy(index))!] as? String)
            
        }
    }


    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        self.presentControllerWithName("ChordsPic", context: chordSet![(chordSet?.startIndex.advancedBy(rowIndex))!] as? String )
    }
    

}
