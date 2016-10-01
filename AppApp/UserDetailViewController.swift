//
//  UserDetailViewController.swift
//  AppApp
//
//  Created by Andrew Goettler on 9/28/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var selectedUser: AppAppUser?

    @IBOutlet weak var userNameDetail: UILabel!
    @IBOutlet weak var calculatorValueDetail: UILabel!
    @IBOutlet weak var highScoreDetail: UILabel!
    @IBOutlet weak var lastActivityDetail: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let thisUser = selectedUser
        {
            userNameDetail.text = thisUser.getUserName()
            
            calculatorValueDetail.text = String(thisUser.getLastCalculatorValue())
            
            highScoreDetail.text = String(thisUser.getHighestScore())
            
            // TODO: date successfully appears, but format is terrible
            lastActivityDetail.text = thisUser.getLastActiveDate().description
        }
        
        else
        {
            print("Unwrapped nil when attempting to load selectedUser")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
