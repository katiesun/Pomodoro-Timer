//
//  ViewController.swift
//  TimerDemo
//
//  Created by Katherine Sun on 2/7/20.
//  Copyright © 2020 Katherine Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var gobreak: UIButton!

    
    var timer:Timer?
    var endDate:Date?
    var secondsLeft:TimeInterval = 1500.0
    var workseconds:TimeInterval = 1500.0
    var paused = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //configure initial state of the label and button
        updateLabel()
        button.setTitle("Start", for: .normal)
    }
    
    //MARK: Lifecycle
    override func viewWillDisappear(_ animated: Bool) {
        
        // check if timer is running
        if timer != nil && endDate != nil {
            //the timer is running, so stop it
            timer?.invalidate()
            
            //save the end date
            let defaults = UserDefaults.standard
            defaults.set(endDate, forKey: "EndDate")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        //check if there's an end date saved
        
        if let date = defaults.value(forKey: "EndDate") as? Date {
            if Date() > date {
                //timer has expired
            }
            else {
                //get seconds left
                secondsLeft = date.timeIntervalSince(Date())
                //start the timer
                timerStart()
            }
            
            defaults.set(nil, forKey: "EndDate")
        }
        
    }
    
    
    //MARK: UI
    func updateLabel() {
        if label != nil {
            label.textColor = UIColor.systemGray
            label.shadowColor = UIColor.white
            label.text = timeString(time: secondsLeft)
        }
    }
    
    //change timer seconds after option selected in settings
    func changeworkSeconds(s:TimeInterval) {
        secondsLeft = s
        workseconds = s
        updateLabel()
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        if workseconds<3600.0 {
            return String(format:"%02i:%02i", minutes, seconds)
        }
        else {
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
    }
    
    //MARK: Timer function
    @objc func timerTick() {
        //decrement the seconds left
        secondsLeft -= 1
        //update label
        updateLabel()
        
        //check if timer has expired
        if secondsLeft <= 0 {
            timerEnd()
        }
    }
    
    func timerStart() {
        button.setTitleColor(UIColor.black, for: .normal)
        //Create timer and run it
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        
            //Set an end date
            endDate = Date().addingTimeInterval(secondsLeft)
            
            //Update label
            updateLabel()
            
            //Update text of label
            button.setTitle("Pause", for: .normal)
    }
    
    func timerPause() {
        //kill timer
        timer?.invalidate()
        //reset the end date
        endDate = nil
        //update button text
        button.setTitle("Continue", for: .normal)
        paused = true
    }
    
    func timerEnd() {
        //kill the timer
        timer?.invalidate()
        //reset the timer
        timer=nil
        //reset the end date
        //endDate = nil
        //update the button text
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitle("Done! Press 'Restart' to begin again.", for: .normal)
    }
    
    func timerReset() {
        timer?.invalidate()
        secondsLeft=workseconds
        endDate = nil
        updateLabel()
    }
    
    //MARK: User Interaction
    @IBAction func tapped(_ sender:Any) {
        
        if paused==true {
            timerStart()
            paused = false
        }
        else {
            timerPause()
        }
       
}
    @IBAction func restart(_ sender: Any) {
        timerReset()
        button.setTitle("Start", for: .normal)
        paused=true
    }
    @IBAction func gobreak(_ sender: Any) {
        timerPause()
    }
    
}
