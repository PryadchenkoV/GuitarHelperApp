//
//  StopWatchPicControl.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 13.07.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import WatchKit
import Foundation


class StopWatchPicControl: WKInterfaceController {

    @IBOutlet var imgNextChord: WKInterfaceImage!
    @IBOutlet var lableCountDown: WKInterfaceLabel!
    @IBOutlet var imgCurChord: WKInterfaceImage!
    
    var currentChordIndex = 0
    var currentChordCountDownTime = 0.0
    
    var countDownToStartTimer = 6
    
    var countDownTimer = NSTimer()
    
    var songIndex: Int?
    
    var valueTempDefault = 120.0
    var valueTempCalculated: Double?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let newContext = context{
            songIndex = newContext as? Int
        }
        valueTempDefault = myDict![String(songIndex!)]![kBeatRateLinePList]! as! Double
        valueTempCalculated = valueTempDefault/Double(vSpeedMetronomeValue)
        if valueTempCalculated < 0.5 || valueTempCalculated > 4 {
            valueTempCalculated = 1
        }
        print("temp = \(valueTempCalculated)")
        
        var chord = myDict![String(songIndex!)]![kChordArrayLinePList]!![String(0)]!!
        var chordValue: String = chord[kChordLinePList] as! String
        let image : UIImage = UIImage(named: chordValue)!
        chord = myDict![String(songIndex!)]![kChordArrayLinePList]!![String(1)]!!
        chordValue = chord[kChordLinePList] as! String
        let imageNew : UIImage = UIImage(named: chordValue)!
        imgCurChord.setImage(image)
        imgNextChord.setImage(imageNew)
        lableCountDown.setText("")
        countDownToStart()
    }
    
    func showChordAtIndex(chordIndex: Int) {
        let chord = myDict![String(songIndex!)]![kChordArrayLinePList]!![String(chordIndex)]!!
        let chordValue: String = chord[kChordLinePList] as! String
        let chordDuration: Double = Double(chord[kDurationLinePList] as! String)! * valueTempCalculated!
        currentChordCountDownTime = chordDuration
        let image : UIImage = UIImage(named:"\(chordValue)")!
        imgCurChord.setImage(image)
        lableCountDown.setText(String(format: "%.1f", chordDuration))
        
        if currentChordIndex < myDict![String(songIndex!)]![kChordArrayLinePList]!!.count - 1  {
            let nextChord = myDict![String(songIndex!)]![kChordArrayLinePList]!![String(chordIndex + 1)]!!
            let nextChordValue: String = nextChord[kChordLinePList] as! String
            
            let imageNew : UIImage = UIImage(named:"\(nextChordValue)")!
            imgNextChord.setImage(imageNew)
            //lableNextAcc.setText(nextChordValue)
        } else {
            imgNextChord.setImage(nil)
            //lableNextAcc.setText(nil)
        }
        
        countDownTimer.invalidate()
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(countDownFunc), userInfo: nil, repeats: true)
    }
    
    func countDownToStart() {
        if countDownToStartTimer >= 0 {
            lableCountDown.setText(String(countDownToStartTimer))
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
            let imageNew : UIImage = UIImage(named:"metal")!
            imgCurChord.setImage(imageNew)
            //lableCurrentAcc.setText("🤘")
            lableCountDown.setText(String("👍"))
        }
    }


}
