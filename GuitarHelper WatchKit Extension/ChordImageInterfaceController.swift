//
//  ChordImageInterfaceController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 13.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation


class ChordImageInterfaceController: WKInterfaceController {
    
    @IBOutlet var lableLibraryChord: WKInterfaceLabel!

    @IBOutlet var imageChord: WKInterfaceImage!
    var chordChoose = ""
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let newContext = context{
            chordChoose = newContext as! String
        }
        let image : UIImage = UIImage(named:chordChoose)!
        imageChord.setImage(image)
        lableLibraryChord.setText(chordChoose)
        // Configure interface objects here.
    }

}
