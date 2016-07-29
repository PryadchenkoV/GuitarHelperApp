//
//  InterfaceController.swift
//  GuitarHelper_v1.0 WatchKit Extension
//
//  Created by Administrator on 11/07/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import WatchKit
import Foundation

let kChordParameterName = "chord"
let kDurationParameterName = "duration"
let kTimerDuration = 0.1

class ChordsChangeInterfaceController: WKInterfaceController {
    
    @IBOutlet var lableNextAcc: WKInterfaceLabel!
    @IBOutlet var lableCurrentAcc: WKInterfaceLabel!
    @IBOutlet var lableCountDown: WKInterfaceLabel!
    
    var chords: [[String : AnyObject]] = [
        [
            kChordParameterName : "A5",
            kDurationParameterName : 3.0
        ],
        [
            kChordParameterName : "F5",
            kDurationParameterName : 4.0
        ],
        [
            kChordParameterName : "D5",
            kDurationParameterName : 2.0
        ],
        [
            kChordParameterName : "A5",
            kDurationParameterName : 3.0
        ],
        [
            kChordParameterName : "F5",
            kDurationParameterName : 1.0
        ],
        [
            kChordParameterName : "D",
            kDurationParameterName : 8.0
        ],
        ]
    
    var currentChordIndex = 0
    var currentChordCountDownTime = 0.0
    
    var countDownToStartTimer = 5
    
    var countDownTimer = NSTimer()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        lableNextAcc.setText("")
        lableCountDown.setText("")
        countDownToStart()
    }
    
    func showChordAtIndex(chordIndex: Int) {
        let chord = chords[chordIndex]
        let chordValue: String = chord[kChordParameterName] as! String
        let chordDuration: Double = chord[kDurationParameterName] as! Double
        currentChordCountDownTime = chordDuration
        
        lableCurrentAcc.setText(chordValue)
        lableCountDown.setText(String(chordDuration))
        
        if currentChordIndex < chords.count-1 {
            let nextChord = chords[chordIndex + 1]
            let nextChordValue: String = nextChord[kChordParameterName] as! String
            
            lableNextAcc.setText(nextChordValue)
        } else {
            lableNextAcc.setText(nil)
        }
        
        countDownTimer.invalidate()
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(countDownFunc), userInfo: nil, repeats: true)
    }
    
    func countDownToStart() {
        if countDownToStartTimer >= 0 {
            lableCurrentAcc.setText(String(countDownToStartTimer))
            countDownToStartTimer -= 1
            countDownTimer.invalidate()
            countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(countDownToStart), userInfo: nil, repeats: false)
        } else {
            showChordAtIndex(0)
        }
    }
    
    func countDownFunc() {
        if currentChordCountDownTime >= 0.1 {
            currentChordCountDownTime -= 0.1
            lableCountDown.setText(String(format: "%.1f", currentChordCountDownTime))
            return
        }
        
        currentChordIndex += 1
        
        if currentChordIndex < chords.count {
            showChordAtIndex(currentChordIndex)
        } else {
            lableCurrentAcc.setText("🤘")
            lableCountDown.setText(String("You Rock!"))
        }
    }
    
        
    
}
