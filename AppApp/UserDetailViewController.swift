//
//  UserDetailViewController.swift
//  AppApp
//
//  Created by Andrew Goettler on 9/28/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var currentUserList: AppAppUserList?
    var selectedUserIndex: Int?
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
            updateAllUserDetails(user: thisUser)
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
    
    @IBAction func makeActiveUserPressed(_ sender: UIButton)
    {
        print("Making \(selectedUser!.getUserName()) the active user")
        
        // activate the user
        self.currentUserList?.activateUserAt(index: self.selectedUserIndex!)
        
        // update the date in the user detail view
        updateLastActivityDetail(user: selectedUser!)
    }
    
    public func updateAllUserDetails(user: AppAppUser)
    {
        updateUserNameDetail(user: user)
        updateCalculatorValueDetail(user: user)
        updateHighestScoreDetail(user: user)
        updateLastActivityDetail(user: user)
    }
    
    public func updateUserNameDetail(user: AppAppUser)
    {
        userNameDetail.text = user.getUserName()
    }
    
    public func updateCalculatorValueDetail(user: AppAppUser)
    {
        calculatorValueDetail.text = "Last calculator value: " + String(user.getLastCalculatorValue())
    }
    
    public func updateHighestScoreDetail(user: AppAppUser)
    {
        highScoreDetail.text = "Highest score: " + String(user.getHighestScore())
    }
    
    public func updateLastActivityDetail(user: AppAppUser)
    {
        // TODO: date appears, but formatting is terrible
        lastActivityDetail.text = "Last activated: " + user.getLastActiveDate().description
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
