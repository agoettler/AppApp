//
//  ViewController.swift
//  AppApp
//
//  Created by Andrew Goettler on 9/27/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var newUserTextField: UITextField!
    
    var currentlyEditingNewUserTextField: Bool = false
    
    var currentUserList: AppAppUserList = AppAppUserList(userNames: ["Bill", "Bob", "Jebediah"])
    
//    let defaults = UserDefaults.standard
//    
//    let defaultsUserListKey = "storedUserList"
    
    //defaults.set(currentUserList, forKey: defaultsUserListKey)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("ViewController viewDidLoad")
        
        // retrieve any stored user list in user defaults
        // use the following code to store to the list
        //defaults.set(currentUserList, forKey: defaultsUserListKey)
//        if let storedUserList = defaults.object(forKey: defaultsUserListKey)
//        {
//            // I think this should cast the default's "any" type as the type I need
//            currentUserList = storedUserList as! AppAppUserList
//        }
        
        // Pass the other view controllers a reference to the user list - essentially the "model" in this app
        // FIXME: this code will break if the order of the tab items is changed
        let otherViewControllers = self.tabBarController?.viewControllers
        
        let gameController = otherViewControllers![0] as! TappingGameViewController
        
        gameController.currentUserList = self.currentUserList
        
        let calculatorController = otherViewControllers![2] as! CalculatorViewController
        
        calculatorController.currentUserList = self.currentUserList
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        print("ViewController did appear")
        
        self.userTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        print("ViewController viewWillAppear")
        
        // reload the table view each time tabs are switched
        self.userTableView.reloadData()
        
    }

    // required functions for UITableViewDataSource protocol
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return currentUserList.userCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellNumber: Int = indexPath.row
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell")! as UITableViewCell
        
        cell.textLabel!.text = currentUserList.getUserAt(index: cellNumber)!.getUserName()
        
        // the subtitle will indicate which user is currently active
        if currentUserList.getUserAt(index: cellNumber)!.getUserActivity()
        {
            cell.detailTextLabel!.text = "Active"
        }
            
        else
        {
            cell.detailTextLabel!.text = " "
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
        print("View controller preparing for segue to \(segue.identifier)")
        
        if segue.identifier == "UserDetailSegue"
        {
            if let destinationViewController: UserDetailViewController = segue.destination as? UserDetailViewController
            {
                let userIndex: Int = (userTableView.indexPathForSelectedRow! as NSIndexPath).row
                
                destinationViewController.currentUserList = self.currentUserList
                
                destinationViewController.selectedUserIndex = userIndex
                
                destinationViewController.selectedUser = currentUserList.getUserAt(index: userIndex)
                
                print("Preparing to display detail for user: \(destinationViewController.selectedUser!.getUserName())")
            }
            
            else
            {
                print("Could not unwrap the destination segue")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print("newUserTextField: textFieldShouldReturn with text: \(textField.text)")
        
        // create a new user with the entered text as the username
        let newUserName = textField.text!
        
        self.currentUserList.addNewUser(userName: newUserName)
        
        // force the table to reload and display the new user
        self.userTableView.reloadData()
        
        // resign the first responder
        textField.resignFirstResponder()
        
        currentlyEditingNewUserTextField = false
        
        // reset the default text
        textField.text = "Add new user…"
        
        // save the user list to userDefaults
//        defaults.set(currentUserList, forKey: defaultsUserListKey)
        
        return false
    }
    
    @IBAction func newUserTextFieldEditingDidBegin(_ sender: UITextField)
    {
        print("newUserTextField: editingDidBegin")
        
        // clear the default text if the user has selected the text field
        // this allows any text entered by the user to persist if they change views while entering text
        if !currentlyEditingNewUserTextField
        {
            sender.text = ""
            
            currentlyEditingNewUserTextField = true
        }
    }
    
    @IBAction func newUserTextFieldEditingChanged(_ sender: UITextField)
    {
        //print("newUserTextField: editingChanged")
    }
    
    @IBAction func newUserTextFieldEditingDidEnd(_ sender: UITextField)
    {
        print("newUserTextField: editingDidEnd with text: \(sender.text)")
        
        // save the user list again, just to be safe
//        defaults.set(currentUserList, forKey: defaultsUserListKey)
    }
}

