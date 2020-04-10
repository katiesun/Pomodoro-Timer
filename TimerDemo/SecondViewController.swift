//
//  SecondViewController.swift
//  TimerDemo
//
//  Created by Katherine Sun on 2/13/20.
//  Copyright © 2020 Katherine Sun. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var gofocus: UIButton!
    
    
      var timer:Timer?
      var endDate:Date?
      var breakseconds:TimeInterval = 300.0
      var breaksecondsLeft:TimeInterval = 300.0
      var paused = true
    
      override func viewDidLoad() {
             super.viewDidLoad()
             // Do any additional setup after loading the view.
             
             //configure initial state of the label and button
             updateLabel()
             Button.setTitle("Start", for: .normal)
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
                   breaksecondsLeft = date.timeIntervalSince(Date())
                   //start the timer
                   timerStart()
               }
               
               defaults.set(nil, forKey: "EndDate")
           }
           
       }
    
    //MARK: UI
    
    
    func updateLabel() {
            
        if Label != nil {
        Label.text = String(ViewController().timeString(time: breaksecondsLeft))
        }

    }
    
    //change timer seconds after option selected in settings
    func changebreakSeconds(s:TimeInterval) {
        breaksecondsLeft = s
        breakseconds = s
        updateLabel()
    }
        
    //MARK: Timer function
    @objc func timerTick() {
        //decrement the seconds left
        breaksecondsLeft -= 1
        //update label
        updateLabel()
            
        //check if timer has expired
        if breaksecondsLeft <= 0 {
                timerEnd()
        }
    }
        
    func timerStart() {
        //Button.setTitleColor(UIColor.black, for: .normal)
        //Create timer and run it
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
            
            //Set an end date
            endDate = Date().addingTimeInterval(breaksecondsLeft)
                
            //Update label
            updateLabel()
                
            //Update text of label
            Button.setTitle("Pause", for: .normal)
    }
        
    func timerPause() {
        //kill timer
        timer?.invalidate()
        //reset the end date
        //update button text
        Button.setTitle("Continue", for: .normal)
    }
        
    func timerEnd() {
        //kill the timer
        timer?.invalidate()
        //reset the timer
        timer=nil
        //reset the end date
        endDate = nil
        //update the button text
        Button.setTitleColor(UIColor.red, for: .normal)
        Button.setTitle("Done! Press 'FOCUS' to begin working again!", for: .normal)
    }
        
    func timerReset() {
        timer?.invalidate()
        breaksecondsLeft = breakseconds
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
            paused = true
        }
           
    }
        
    
    @IBAction func gofocus(_ sender: Any) {
        timerPause()
        paused = true
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
