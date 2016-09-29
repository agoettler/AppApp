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
    
    public init()
    {
        
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
}
