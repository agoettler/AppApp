//
//  AppAppUser.swift
//  AppApp
//
//  Created by Andrew Goettler on 9/28/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import Foundation

class AppAppUser
{
    // stores the name of the user
    private var userName: String = ""
    
    // stores the most recent value in the user's calculator display
    private var lastCalculatorValue: Float = 0
    
    // stores the user's highest score in the tapping game
    private var highestScore: Int = 0
    
    // stores the last time this user was the active user
    // not completely sure what this will do
    private var lastActiveDate: Date = Date.distantPast
    
    // true if this user is the current active user
    private var isUserActive: Bool = false
    
    // argument-less initializer
    public init()
    {
        
    }
    
    // initializer accepts a name
    public init(name: String)
    {
        self.setUserName(name: name)
    }
    
    public func getUserName() -> String
    {
        return self.userName
    }
    
    public func setUserName(name: String)
    {
        self.userName = name
    }
    
    public func getLastCalculatorValue() -> Float
    {
        return self.lastCalculatorValue
    }
    
    public func setLastCalculatorValue(value: Float)
    {
        self.lastCalculatorValue = value
    }
    
    public func getHighestScore() -> Int
    {
        return self.highestScore
    }
    
    public func setHighestScore(score: Int)
    {
        self.highestScore = score
    }
    
    public func getLastActiveDate() -> Date
    {
        return self.lastActiveDate
    }
    
    public func setLastActiveDate(date: Date)
    {
        self.lastActiveDate = date
    }
    
    public func setUserActivity(isActive: Bool)
    {
        self.isUserActive = isActive
    }
    
    public func getUserActivity() -> Bool
    {
        return self.isUserActive
    }
    
    public func activateUser()
    {
        self.setUserActivity(isActive: true)
        self.setLastActiveDate(date: Date.init())
    }
    
    public func deactivateUser()
    {
        self.setUserActivity(isActive: false)
    }
}
