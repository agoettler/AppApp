//
//  Stack.swift
//  MyCalculator
//
//  Created by Andrew Goettler on 9/6/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import Foundation

// following along with the tutorial in the Generics chapter of "The Swift ProgrammingLanguage", p. 806
public class Stack<Element> {
    
    private var items = [Element]()
    
    public init() {
        
    }
    
    // pushes an item onto the stack
    public func push(_ item: Element) {
        
        items.append(item)
        
    }
    
    // pops an item off of the stack; returns nil if stack is empty
    public func pop() -> Element? {
        
        return self.isEmpty() ? nil : items.removeLast()
        
    }
    
    // returns the top item without removing it from the stack; returns nil if stack is empty
    public func peek() -> Element? {
        
        return self.isEmpty() ? nil : items.last
        
    }
    
    // returns true if the stack is empty
    public func isEmpty() -> Bool {
        
        return items.isEmpty
        
    }
    
    // removes all elements from the stack
    public func removeAll() {
        
        items.removeAll()
        
    }
    
    // returns a string representation of the current state of the stack
    public func description() -> String {
        
        return items.description
        
    }
    
}
