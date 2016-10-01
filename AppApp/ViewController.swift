//
//  ViewController.swift
//  AppApp
//
//  Created by Andrew Goettler on 9/27/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var userTableView: UITableView!
    
    var sampleUserList: AppAppUserList = AppAppUserList(userNames: ["Bill", "Bob", "Jebediah"])

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // required functions for UITableViewDataSource protocol
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sampleUserList.userCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellNumber: Int = indexPath.row
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell")! as UITableViewCell
        
        cell.textLabel!.text = sampleUserList.getUserAt(index: cellNumber)!.getUserName()
        
        // the subtitle will indicate which user is currently active
        if sampleUserList.getUserAt(index: cellNumber)!.getUserActivity()
        {
            cell.detailTextLabel!.text = "Active"
        }
            
        else
        {
            cell.detailTextLabel!.text = ""
        }
        
        return cell
    }
    
    // two optional UITableViewDelegate functions
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        // some tutorials demonstrate issuing the segue from here; am confused
        print("Did select row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        print("Will select row: \(indexPath.row)")
        
        return indexPath
    }
    
    // override the prepare function to populate the user detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "UserDetailSegue"
        {
            if let destinationViewController: UserDetailViewController = segue.destination as? UserDetailViewController
            {
                let userIndex: Int = (userTableView.indexPathForSelectedRow! as NSIndexPath).row
                
                destinationViewController.currentUserList = self.sampleUserList
                
                destinationViewController.selectedUserIndex = userIndex
                
                destinationViewController.selectedUser = sampleUserList.getUserAt(index: userIndex)
                
                print("Preparing to display detail for user: \(destinationViewController.selectedUser!.getUserName())")
            }
            
            else
            {
                print("Could not unwrap the destination segue")
            }
        }
    }
}

