//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

func mathStuffFactory(_ opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}


func customMap (mapArray: [Double], closure: (Double) -> Double) -> [Double] {
    var newMapArray = [Double]()
    for double in mapArray {
        newMapArray.append(closure(double))
    }
    return newMapArray
}

func customFilter (filterArray: [Double], closure: (Double) -> Bool) -> [Double] {
    var newFilterArray = [Double]()
    for num in filterArray {
        if closure(num) == true {
            newFilterArray.append(num)
        }
    }
    return newFilterArray
}

func customReduce(reduceArray: [Double], initValue: (Double), closure: (Double, Double) -> Double ) -> Double {
    var currentValue = initValue
    var nextValue = Double()
    for number in reduceArray {
        nextValue = number
        currentValue = closure(currentValue, nextValue)
    }
    
    return currentValue
}

var calcIsOn = true
var invalidStatement = "invalid entry"
repeat {
    
    print("what would you like to do?")
    print("options: (a) calculate, (b) play game, (c) higher order function")
    
    let unsafeUserChoice = readLine()?.lowercased()
    guard let userOptionChoice = unsafeUserChoice else {
        print("try again")
        continue
    }
    
    if userOptionChoice.count != 1 {
        print(invalidStatement)
        continue
    }
    
    
    switch userOptionChoice {
    case "a": //calculate
        print("\nWhat would you like to calculate?")
        
        let userInput = readLine()?.lowercased()
        guard let safeUserInput = userInput else {
            print(invalidStatement)
            continue
        }
        
        
        let userArrayEquation = safeUserInput.components(separatedBy: " ")
        if  userArrayEquation.count != 3 {
            print("please enter again")
            continue
        }
        
        let userOperator = userArrayEquation[1]
        let userOperands = (num1: Double(userArrayEquation[0]) ?? 0.0, num2: Double(userArrayEquation[2]) ?? 0.0)
        
        
        let operation = mathStuffFactory(userOperator)
        let equationResult = operation(userOperands.num1, userOperands.num2)
        print("you entered: \(safeUserInput)")
        print("result: \(equationResult)\n")
        
        
        
        
    case "b"://mathgame
        print("\nPlease enter a mystery equation. Ex: 8 ? 7")
        
        
        let userInput = readLine()?.lowercased()
        guard let safeUserInput = userInput else {
            print(invalidStatement)
            continue
        }
        
        
        let userArrayEquation = safeUserInput.components(separatedBy: " ")
        let userOperator = userArrayEquation[1]
        let userOperands = (num1: Double(userArrayEquation[0]) ?? 0.0, num2: Double(userArrayEquation[2]) ?? 0.0)
        
        
        let mysterySymbol = "?"
        let operationsArray = ["+", "-", "/", "*"]
        var mysteryOperation = ""
        
        if let random = operationsArray.randomElement() {
            mysteryOperation = random
        }
        
        if userOperator == mysterySymbol {
            let operation = mathStuffFactory(mysteryOperation)
            let equationResult = operation(userOperands.num1, userOperands.num2)
            print("you entered: \(safeUserInput)")
            print("result: \(equationResult)")
            print("\nGuess the operation:")
            
            let userInput = readLine()?.lowercased()
            guard let safeUserInput = userInput else {
                print(invalidStatement)
                continue
            }
            if safeUserInput == mysteryOperation {
                print("Yay! You win! ^.^\n")
            } else {
                print("Sorry, answer was \'\(mysteryOperation)\' better luck next time!\n")
                
            }
        }  else {
            print("I don't like that, please follow example. ^.^\n")
            continue
        }
        
    case "c":
        print("Indicate the higher order fuction you'd like to use: map, filter, reduce, then enter your array and operation. \nex: input: reduce 1,2,3,4 by - 2    \n output: 1")
        
        
        if let userInput = readLine()?.components(separatedBy: " "){
            if userInput.count != 5 {
                print(invalidStatement)
                continue
            }
            let inputAsComponents = userInput
            let inputArray = inputAsComponents[1].components(separatedBy: ",").compactMap(){Double($0)}
            let userOperator = inputAsComponents[3]
            let userGivenNumber = Double(inputAsComponents[4]) ?? 0
            
            
            //var higherOrderFunctions = ["map", "filter", "reduce"]
            switch userInput[0] {
                
            case "map":
                
                switch userOperator {
                case "*":
                    print("result: \(customMap(mapArray: inputArray, closure: {$0 * userGivenNumber}))")
                case "/":
                    print("result: \(customMap(mapArray: inputArray, closure: {$0 / userGivenNumber}))")
                default:
                    print(invalidStatement)
                }
                
                
            case "filter":
                switch userOperator {
                case ">":
                    print("result: \(customFilter(filterArray: inputArray, closure: {$0 > userGivenNumber}))")
                case "<":
                    print("result: \(customFilter(filterArray: inputArray, closure: {$0 < userGivenNumber}))")
                default:
                    print(invalidStatement)
                }
                
            case "reduce":
                switch userOperator {
                case "+":
                    print("result: \(customReduce(reduceArray: inputArray, initValue: userGivenNumber, closure: {$0 + $1}))")
                case "-":
                    print("result: \(customReduce(reduceArray: inputArray, initValue: userGivenNumber, closure: {$0 - $1}))")
                default:
                    print(invalidStatement)
                }
            default :
                print("try again")
                
            }
        }
    default:
        print("try again")
        continue
    }
    
    print("Would you like to do something else?")
    let userReply = readLine()?.lowercased()
    guard let safeUserReply = userReply else {
        print("try again")
        continue
    }
    
    if safeUserReply == "y" || safeUserReply == "yes" {
        calcIsOn = true
    } else {
        calcIsOn = false
        print("thanks, see you later!")
    }
    
} while calcIsOn

