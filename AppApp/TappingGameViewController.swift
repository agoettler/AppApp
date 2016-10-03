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
    
    @IBOutlet weak var tapCounterDisplay: UILabel!
    
    @IBOutlet var gameTapGestureRecognizer: UITapGestureRecognizer!
    
    let gameLength: Int = 10
    
    let gameStartText = "Ready!"
    
    let gameEndText = "Done!"
    
    var gameTimer: Timer = Timer()
    
    var timeCounter: Int = 0
    
    var timerRunning: Bool = false
    
    var numberOfTaps: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("TappingGame ViewDidLoad")
        
        timeCounterLabel.text = gameStartText
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        print("TappingGame viewDidAppear")
        
        if !timerRunning
        {
            timeCounterLabel.text = gameStartText
        }
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
            
            numberOfTaps = 0
            
            updateTapCounter(taps: numberOfTaps)
            
            // TODO: find a way to "gray out" the button when it's disabled
            timerStartButton.isEnabled = false
            
            timeCounter = gameLength
            
            timeCounterLabel.text = String(timeCounter)
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TappingGameViewController.updateTimeCounter), userInfo: nil, repeats: true)
        }
    }
    
    public func updateTimeCounter()
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
            
            timerStartButton.isEnabled = true
            
            timeCounterLabel.text = gameEndText
        }
    }
    
    public func updateTapCounter(taps: Int)
    {
        tapCounterDisplay.text = "Taps: " + String(taps)
    }
    
    @IBAction func tapHappened(_ sender: UITapGestureRecognizer)
    {
        //print("Tap happened in TappingGameViewController")
        
        if timerRunning
        {
            numberOfTaps += 1
            
            updateTapCounter(taps: numberOfTaps)
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
