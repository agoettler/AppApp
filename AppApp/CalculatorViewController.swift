//
//  CalculatorViewController.swift
//  AppApp
//
//  Created by Andrew Goettler on 10/2/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var calculatorDisplay: UILabel!
    @IBOutlet weak var entriesDisplay: UILabel!
    
    
    var userIsEnteringNumber: Bool = false
    var decimalEntered: Bool = false
    var isDisplayingResult: Bool = false
    var calculatorModel: RPNCalculatorModel = RPNCalculatorModel()
    let operationsDictionary = ["+" : CalculatorOperation.addition, "-" : CalculatorOperation.subtraction, "×" : CalculatorOperation.multiplication, "÷" : CalculatorOperation.division, "√" : CalculatorOperation.squareRoot, "π" : CalculatorOperation.pi, "sin" : CalculatorOperation.sine, "cos" : CalculatorOperation.cosine, "±" : CalculatorOperation.negation]
    
    let calculatorDisplayReturnedNil = "calculatorDisplay returned nil"
    let entriesDisplayReturnedNil = "entriesDisplay returned nil"
    
    @IBAction func digitPressed(_ sender: AnyObject) {
        
        // let's try this optional binding thing
        if let digitEntered: String = sender.currentTitle {
            
            print("Digit button '\(digitEntered)' was pressed")
            
            if let currentDisplayText: String = calculatorDisplay.text {
                
                if !isDisplayingResult && userIsEnteringNumber {
                    
                    calculatorDisplay.text = currentDisplayText + digitEntered
                    
                } else {
                    
                    userIsEnteringNumber = true
                    isDisplayingResult = false
                    
                    calculatorDisplay.text = digitEntered
                    
                }
                
            } else {
                print(calculatorDisplayReturnedNil)
            }
            
        } else {
            
            print("nil value received")
            
        }
        
    }
    
    @IBAction func operationPressed(_ sender: AnyObject) {
        
        if let operationEntered: String = sender.currentTitle {
            
            print("Operation button '\(operationEntered)' was pressed")
            
            if let operation: CalculatorOperation = operationsDictionary[operationEntered] {
                
                // don't repeat yourself!
                // doesn't need arguments since all variables necessary are in scope
                func resolveOperation() {
                    
                    let result: String = calculatorModel.performOperation(operation: operation)
                    
                    calculatorDisplay.text = "\(result)"
                    
                    appendToEntriesList(nextEntry: operationEntered)
                    
                    isDisplayingResult = true
                    
                }
                
                if userIsEnteringNumber {
                    
                    // if the user presses negation while entering a number, negate the value in the display
                    if operation == .negation {
                        
                        if let currentDisplayText: String = calculatorDisplay.text {
                            
                            calculatorDisplay.text = "-" + currentDisplayText
                            
                        } else {
                            
                            print(calculatorDisplayReturnedNil)
                            
                        }
                        
                    } else {
                        
                        // if the user presses any other operation while entering a number, push the number onto the stack and perform computation
                        self.enterPressed()
                        
                        resolveOperation()
                        
                    }
                    
                    
                } else {
                    
                    resolveOperation()
                }
                
                
                
            } else {
                
                print("No valid operation found")
                
            }
            
        } else {
            
            print("operationEntered received a nil value from the sender")
            
        }
        
    }
    
    @IBAction func enterPressed() {
        print("Enter button pressed")
        if let currentDisplayText: String = calculatorDisplay.text {
            
            if let number: Double = Double(currentDisplayText) {
                
                userIsEnteringNumber = false
                
                decimalEntered = false
                
                isDisplayingResult = true
                
                print("Value '\(number)' sent to model")
                
                calculatorModel.enterNumber(number: number)
                
                appendToEntriesList(nextEntry: currentDisplayText)
                
            } else {
                
                print("Entered value could not be converted to float")
                
                calculatorDisplay.text = "0"
                
            }
        }
    }
    
    
    @IBAction func backSpacePressed(_ sender: AnyObject) {
        print("Backspace button pressed")
        
        // prevent the user from backspacing a result or an entered number
        if userIsEnteringNumber {
            
            // it appears possible to optional bind to a var, but this works fine for now
            if let currentDisplayText = calculatorDisplay.text {
                
                // must be able to modify the string
                var newDisplayText: String = currentDisplayText
                
                // removing seems to return the character removed, not the modified string
                newDisplayText.remove(at: newDisplayText.index(before: newDisplayText.endIndex))
                
                // if all characters have been backspaced away, show a 0 in the display
                if newDisplayText == "" {
                    
                    userIsEnteringNumber = false
                    
                    calculatorDisplay.text = "0"
                    
                } else {
                    
                    calculatorDisplay.text = newDisplayText
                    
                }
                
            }
        }
        
    }
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        print("Clear button pressed")
        
        calculatorModel.clearCalculator()
        
        calculatorDisplay.text = "0"
        
        entriesDisplay.text = ""
        
        decimalEntered = false
        
        userIsEnteringNumber = false
        
        isDisplayingResult = false
    }
    
    @IBAction func decimalPressed(_ sender: AnyObject) {
        print("Decimal button pressed")
        if let currentDisplayText: String = calculatorDisplay.text {
            
            if !decimalEntered {
                
                decimalEntered = true
                
                if isDisplayingResult {
                    
                    userIsEnteringNumber = true
                    
                    isDisplayingResult = false
                    
                    calculatorDisplay.text = "0."
                    
                } else {
                    
                    userIsEnteringNumber = true
                    
                    calculatorDisplay.text = currentDisplayText + "."
                    
                }
                
            }
            
        } else {
            
            print(calculatorDisplayReturnedNil)
            
        }
    }
    
    func appendToEntriesList(nextEntry: String) {
        if let currentEntryList: String = entriesDisplay.text {
            entriesDisplay.text = currentEntryList + " " + nextEntry
        } else {
            print(entriesDisplayReturnedNil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
