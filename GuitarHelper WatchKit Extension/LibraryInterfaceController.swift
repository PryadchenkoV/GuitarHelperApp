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

    var chordSet: [String]?
    var bufArr:[String] = []

    
    @IBOutlet var tableLibrary: WKInterfaceTable!
    
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
        chordSet = Set(bufArr).sort()
//        print(chordSet!.sort())
//        print((chordSet?.count)!)
        tableLibrary.setNumberOfRows((
            chordSet!.count), withRowType: "LibraryTableList")
        for index in 0...(chordSet?.count)! - 1{
            let row = tableLibrary.rowControllerAtIndex(index) as! LibraryTableList
            row.lableChordName.setText(chordSet![index])
            
        }
    }


    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        self.presentControllerWithName("ChordsPic", context: chordSet![(chordSet?.startIndex.advancedBy(rowIndex))!] as String )
    }
    

}
