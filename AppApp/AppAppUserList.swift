//
//  AppAppUserList.swift
//  AppApp
//
//  Created by Andrew Goettler on 9/28/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import Foundation

class AppAppUserList
{
    // not private for now; don't have time to implement all of the array methods
    var userList: [AppAppUser] = []
    
    // store the current active user; at startup, there may not be an active user
    var currentActiveUser: AppAppUser?
    
    public init()
    {
        
    }
    
    // create a UserList from an array of users (this is much too silly)
    public init(users: [AppAppUser])
    {
        userList.append(contentsOf: users)
    }
    
    // create a UserList from an array of user names
    public init(userNames: [String])
    {
        for name in userNames
        {
            userList.append(AppAppUser(name: name))
        }
    }
    
    public func addNewUser(userName: String)
    {
        self.addNewUser(user: AppAppUser(name: userName))
    }
    
    public func addNewUser(user: AppAppUser)
    {
        self.userList.append(user)
        
        print("Added user: \(self.userList.last!.getUserName())")
    }
    
    public func userCount() -> Int
    {
        return self.userList.count
    }
    
    public func getCurrentActiveUser() -> AppAppUser?
    {
        return self.currentActiveUser
    }
    
    public func getUserAt(index: Int) -> AppAppUser?
    {
        // perform some basic bounds checking
        if (index >= 0) && (index < self.userCount())
        {
            return self.userList[index]
        }
        
        else
        {
            return nil
        }
    }
    
    public func activateUserAt(index: Int)
    {
        // check if there is currently an active user
        if let activeUser = currentActiveUser
        {
            // only activate a user if the requested user isn't already active
            if self.getUserAt(index: index)!.getUserActivity() == false
            {
                // set the current active user to inactive
                activeUser.deactivateUser()
                
                // set the new active user to active
                self.getUserAt(index: index)!.activateUser()
                
                self.currentActiveUser = self.getUserAt(index: index)!
                
                print("Made \(self.getUserAt(index: index)!.getUserName()) the active user")
            }
            
            // if we're trying to activate the current active user, don't do anything
            else
            {
                print("\(self.currentActiveUser!.getUserName()) is already the active user")
            }
        }
        
        // if there is no current active user, go ahead and activate one
        else
        {
            self.getUserAt(index: index)!.activateUser()
            
            self.currentActiveUser = self.getUserAt(index: index)!
            
            print("Made \(self.currentActiveUser!.getUserName()) the first active user")
        }
    }
}
