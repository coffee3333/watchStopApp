//
//  ViewController.swift
//  test
//
//  Created by Atay on 9/21/20.
//

import UIKit

class ViewTimerController: UIViewController {

    var time = 0
    var minutes = 0
    var hour = 0
    
    var timer = Timer()
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var minuteSlider: UISlider!
    @IBOutlet weak var hourSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hourSlider(_ sender: UISlider){
        if !timer.isValid{
            hour = Int(sender.value)

            let hourLableStr = self.formaterForTime(value: hour)

            if minutes == 0 && time == 0{
                timeLable.text = "\(hourLableStr):00:00"
            }else{
                let minLableStr = self.formaterForTime(value: minutes)
                let secLableStr = self.formaterForTime(value: time)
                timeLable.text = "\(hourLableStr):\(minLableStr):\(secLableStr)"

            }
        }
    }

    @IBAction func minuteSlider(_ sender: UISlider){
        if !timer.isValid{
            minutes = Int(sender.value)
            let minLableStr = self.formaterForTime(value: minutes)

            if hour == 0 && time == 0{
                timeLable.text = "00:\(minLableStr):00"
            }else{
                let hourLableStr = self.formaterForTime(value: hour)
                let secLableStr = self.formaterForTime(value: time)
                timeLable.text = "\(hourLableStr):\(minLableStr):\(secLableStr)"

            }
        }
    }
    
    @IBAction func timeSlider(_ sender: UISlider){
        if !timer.isValid{
            time = Int(sender.value)
            let secLableStr = self.formaterForTime(value: time)

            if minutes == 0 && hour == 0{
                timeLable.text = "00:00:\(secLableStr)"
            }else{
                let minLableStr = self.formaterForTime(value: minutes)
                let hourLableStr = self.formaterForTime(value: hour)
                timeLable.text = "\(hourLableStr):\(minLableStr):\(secLableStr)"
            }
        }
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        if timeLable.text != "00:00:00" {
            if !timer.isValid{
                timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(action),
                                             userInfo: nil,
                                             repeats: true)
                startButton.isEnabled = false
                pauseButton.isEnabled = true
                self.disableSliders()
            }
        }else{
            let alertTime = UIAlertController(title: "Alert", message: "You have to pik a time", preferredStyle: .alert)
            alertTime.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alertTime, animated: true)
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        self.pauseStopEnabler()
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        self.pauseStopEnabler()
        self.enableSliders()
        
        time = 0
        minutes = 0
        hour = 0
        
        secondSlider.value = Float(time)
        minuteSlider.value = Float(minutes)
        hourSlider.value = Float(hour)
        
        timeLable.text = "00:00:00"
    }
    
    
    @objc func action(){
        time -= 1
        if time <= 0 && minutes <= 0 && hour <= 0{
            timer.invalidate()
            
            time = 0
            minutes = 0
            hour = 0
            
            timeLable.text = "00:00:00"
            
            self.pauseStopEnabler()
            self.enableSliders()
            
            let alertTime = UIAlertController(title: "Alert", message: "Tik tok mother #@k%r, time is out", preferredStyle: .alert)
            alertTime.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alertTime, animated: true)
        }
        
        if time < 0{
            minutes -= 1
            time  = 59
        }
        
        if minutes < 0{
            hour -= 1
            minutes = 59
        }
        
        let secLableStr = self.formaterForTime(value: time)
        let minLableStr = self.formaterForTime(value: minutes)
        let hourLableStr = self.formaterForTime(value: hour)
        
        secondSlider.value = Float(time)
        minuteSlider.value = Float(minutes)
        hourSlider.value = Float(hour)
        
        timeLable.text = "\(hourLableStr):\(minLableStr):\(secLableStr)"
    }
    
    func formaterForTime(value : Int) ->(_:String){
        let formatedData = value > 9 ? "\(value)" : "0\(value)"
        return formatedData
    }
    
    func pauseStopEnabler(){
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    func disableSliders(){
        secondSlider.isEnabled = false
        minuteSlider.isEnabled = false
        hourSlider.isEnabled = false
    }
    
    func enableSliders(){
        secondSlider.isEnabled = true
        minuteSlider.isEnabled = true
        hourSlider.isEnabled = true
    }
}

