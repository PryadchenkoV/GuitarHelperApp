//
//  PlayerController.swift
//  GuitarHelper
//
//  Created by Danya on 12.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation


class PlayerController: WKInterfaceController {

    
    @IBOutlet var lableTimeChord: WKInterfaceLabel!
    @IBOutlet var buttonChord: WKInterfaceButton!
    @IBOutlet var lableChord: WKInterfaceLabel!
    
    var countChord = 0
    
    var chordSet: Set<String>?
    var bufArr:[String] = []

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        for i in 0..<myDict![String(chooseSongIndex!)]![kChordArrayLinePList]!!.count {
            let chord = myDict![String(chooseSongIndex!)]![kChordArrayLinePList]!![String(i)]!!
            let chordValue: String = chord[kChordLinePList] as! String
            bufArr.append(chordValue)
        }
        chordSet = Set(bufArr)
        print(chordSet!)
        showImage(countChord)

        
    }
    
    @IBAction func backChordPush() {
        if countChord > 0 {
            countChord -= 1
            showImage(countChord)
        }
    }

    
    @IBAction func buttonChordPushed() {
        if countChord <  chordSet!.count - 1 {
            countChord += 1
            showImage(countChord)
        }
    }
    func showImage (value: Int) {
        let image : UIImage = UIImage(named: chordSet![(chordSet?.startIndex.advancedBy(value))!])!
        lableChord.setText(chordSet![(chordSet?.startIndex.advancedBy(value))!])
        buttonChord.setBackgroundImage(image)
    }
    

}
