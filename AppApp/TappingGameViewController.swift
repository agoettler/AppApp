//
//  TappingGameViewController.swift
//  AppApp
//
//  Created by Andrew Goettler on 10/2/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class TappingGameViewController: UIViewController
{
    @IBOutlet weak var timeCounterLabel: UILabel!
    
    @IBOutlet weak var timerStartButton: UIButton!
    
    var gameTimer: Timer = Timer()
    
    let gameLength: Int = 10
    
    var timeCounter: Int = 0
    
    var timerRunning: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("TappingGame ViewDidLoad")
        
        timeCounterLabel.text = "Ready!"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton)
    {
        // create and start a time if there isn't one already running
        if !timerRunning
        {
            print("Timer started")
            
            timerRunning = true
            
            //timerStartButton.isEnabled = false
            
            timeCounter = gameLength
            
            timeCounterLabel.text = String(timeCounter)
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TappingGameViewController.updateTappingGameCounter), userInfo: nil, repeats: true)
        }
    }
    
    public func updateTappingGameCounter()
    {
        if timeCounter > 0
        {
            timeCounter -= 1
            
            timeCounterLabel.text = String(timeCounter)
        }
        
        else
        {
            print("Timer finished")
            
            timerRunning = false
            
            gameTimer.invalidate()
            
            //timerStartButton.isEnabled = true
            
            timeCounterLabel.text = "Done!"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
