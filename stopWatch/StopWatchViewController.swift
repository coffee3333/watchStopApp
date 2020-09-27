//
//  StopWatchViewController.swift
//  stopWatch
//
//  Created by Atay on 9/27/20.
//

import UIKit

class StopWatchViewController: UIViewController {

    var time = 0
    var minutes = 0
    var hour = 0

    var timer = Timer()
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startButton(_ sender: UIButton) {
        if !timer.isValid{
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                        target: self,
                                        selector: #selector(action),
                                        userInfo: nil,
                                        repeats: true)
            startButton.isEnabled = false
            pauseButton.isEnabled = true

        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        time = 0
        minutes = 0
        hour = 0
        timeLable.text = "00:00:00"
    }
    
    @objc func action(){
        time += 1
        if time == 60{
            minutes += 1
            time  = 0
        }
        if minutes == 60{
            hour += 1
            minutes = 0
        }
        let secLableStr = time > 9 ? "\(time)" : "0\(time)"
        let minLableStr = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hourLableStr = hour > 9 ? "\(hour)" : "0\(hour)"
        
        timeLable.text = "\(hourLableStr):\(minLableStr):\(secLableStr)"
    }
}
