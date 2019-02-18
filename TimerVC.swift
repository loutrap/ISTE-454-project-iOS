//
//  TimerVC.swift
//  SousChef
//
//  Created by Louis Trapani on 3/29/18.
//  Copyright © 2018 trapani. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    
    @IBAction func setTimer(_ sender: UIStepper) {
        sender.maximumValue = 5400
        if sender.value > 0.0 {
            startStopButton.isEnabled = true
            resetButton.isEnabled = true
        } else {
            startStopButton.isEnabled = false
            resetButton.isEnabled = false
        }
        seconds = Int(sender.value) * 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    @IBAction func resetTimer(_ sender: UIButton) {
        seconds = 0
        stepper.value = 0.0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        resetButton.isEnabled = false
        startStopButton.isEnabled = false
    }
    
    @objc func updateTimer() {
        if  seconds < 1 {
            timer.invalidate()
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        
    }
    
    @IBAction func startStopTimer(_ sender: Any) {
        if isTimerRunning == false {
            runTimer()
            stepper.isEnabled = false
            resetButton.isEnabled = false
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            //stop the timer
            timer.invalidate()
            stepper.isEnabled = true
            startStopButton.setTitle("Start", for: .normal)
            isTimerRunning = false
            if seconds > 0 {
                resetButton.isEnabled = true
            }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerVC.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i : %02i : %02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.isEnabled = false
        resetButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
