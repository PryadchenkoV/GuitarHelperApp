//
//  StopWatchControl.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 12.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

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
let kChordArrayLinePList = "ChordList"
let kChordLinePList = "Chord"
let kDurationLinePList = "ChordDuration"


class StopWatchControl: WKInterfaceController {
    
    @IBOutlet var lableNextAcc: WKInterfaceLabel!
    @IBOutlet var lableCurrentAcc: WKInterfaceLabel!
    @IBOutlet var lableCountDown: WKInterfaceLabel!
    
    var currentChordIndex = 0
    var currentChordCountDownTime = 0.0
    
    var countDownToStartTimer = 6
    
    var countDownTimer = NSTimer()
    
    var songIndex: Int?
    
    var counter = 0
    
    var valueTempDefault = 0.0
    var valueTempCalculated: Double?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let newContext = context{
            songIndex = newContext as! Int
        }
        valueTempDefault = myDict![String(songIndex!)]![kBeatRateLinePList]! as! Double
        valueTempCalculated = valueTempDefault/Double(vSpeedMetronomeValue)
        if valueTempCalculated < 0.5 || valueTempCalculated > 208 {
            valueTempCalculated = 1
        }
        print(valueTempCalculated)
        lableNextAcc.setText("\(String(format: "%.2f", valueTempCalculated!))x")
        lableCountDown.setText("")
        countDownToStart()
    }
    
    func showChordAtIndex(chordIndex: Int) {
        let chord = myDict![String(songIndex!)]![kChordArrayLinePList]!![String(chordIndex)]!!
        let chordValue: String = chord[kChordLinePList] as! String
        let chordDuration: Double = Double(chord[kDurationLinePList] as! String)! * valueTempCalculated!
        currentChordCountDownTime = chordDuration
        
        lableCurrentAcc.setText(chordValue)
        lableCountDown.setText(String(format: "%.1f", chordDuration))
        
        if currentChordIndex < myDict![String(songIndex!)]![kChordArrayLinePList]!!.count - 1 {
            let nextChord = myDict![String(songIndex!)]![kChordArrayLinePList]!![String(chordIndex + 1)]!!
            let nextChordValue: String = nextChord[kChordLinePList] as! String
            
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
        if currentChordCountDownTime > 0.1 {
            currentChordCountDownTime -= 0.1
            lableCountDown.setText(String(format: "%.1f", currentChordCountDownTime))
            return
        }
        
        currentChordIndex += 1
        
        if currentChordIndex < myDict![String(songIndex!)]![kChordArrayLinePList]!!.count {
            showChordAtIndex(currentChordIndex)
        } else {
            lableCurrentAcc.setText("🤘")
            lableCountDown.setText(String("You Rock!"))
        }
    }
}

