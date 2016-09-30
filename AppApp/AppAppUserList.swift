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
        self.userList.append(AppAppUser(name: userName))
    }
    
    public func addNewUser(user: AppAppUser)
    {
        self.userList.append(user)
    }
    
    public func userCount() -> Int
    {
        return self.userList.count
    }
    
    public func activateUserAt(index: Int)
    {
        // deactivate the current active user, if there is one
        if let activeUser = currentActiveUser
        {
            activeUser.deactivateUser()
        }
        
        // set the new user to active
        self.userList[index].activateUser()
    }
}
