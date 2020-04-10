//
//  SettingsViewController.swift
//  TimerDemo
//
//  Created by Katherine Sun on 2/26/20.
//  Copyright © 2020 Katherine Sun. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var sessionPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func setOne(_sender:Any) {
        ViewController().changeworkSeconds(s: 1500.0)
        SecondViewController().changebreakSeconds(s: 300.0)
    }
    
    @IBAction func setTwo(_sender:Any) {
        ViewController().changeworkSeconds(s: 3000.0)
        SecondViewController().changebreakSeconds(s: 600.0)
    }
    
    @IBAction func setThree(_sender:Any) {
        ViewController().changeworkSeconds(s: 4500.0)
        SecondViewController().changebreakSeconds(s: 900.0)
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
