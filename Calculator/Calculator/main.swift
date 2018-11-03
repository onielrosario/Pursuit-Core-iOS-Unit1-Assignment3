//
//  main.swift
//  caltest
//
//  Created by Oniel Rosario on 10/29/18.
//  Copyright © 2018 Oniel Rosario. All rights reserved.
//

import Foundation

var calculatorIsRunning = true
let randomOpetators = ["*","+","/","-"]
let words = ["filter","reduce","map"]
let highOrderOperators = ["*","+","/","-","<",">"]
let questionMark = "?"
var guessingLoop = true

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
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
func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    
    
    var newArr = [Int]()
    for num in inputArray {
        if filter(num) {
            newArr.append(num)
        }
    }
    return newArr
}


func customMap (arr: [Int], closure: (Int) -> Int) -> [Int] {
    var newArr = [Int]()
    for num in arr {
        newArr.append(closure(num))
    }
    return newArr
}

func myReduce(arr: [Int], closure: (Int,Int) -> Int, given: Int) -> Int {
    var total = given
    for num in arr {
        total = closure(total,num)
    }
    return total
}
func ifStringIsNum(a: String) -> Bool {
    var isString = false
    if let _ = Int(a) {
        isString = true
    }
    return isString
}

while calculatorIsRunning {
    
    print("ENTER TYPE OF CALCULATION")
    print("")
    print("1 (REGULAR)      2(HIGH ORDER)")
    guard let userInput = readLine() else {
        print("ERROR")
        print("")
        continue
    }
    switch userInput {
    case "1":
        print("ENTER REGULAR OPERATION E.G:")
        print("5 + 2")
        guard let userInput2 = readLine() else {
            continue
        }
        var components = userInput2.components(separatedBy: " ")
        
        guard components.count == 3 else {
            print("PLEASE ENTER A CORRECT OPERATION FORMAT!")
            print("")
            continue
        }
        switch components[1] {
        case "?":
            var userOperator = randomOpetators.randomElement()!
            guard let firstNum = Double(components[0]) else {
                print("PLEASE ENTER CORRECT VALUES")
                continue
            }
            guard let secNum = Double(components[2]) else {
                print("PLEASE ENTER CORRECT VALUES")
                continue
            }
            if userOperator == "/" && secNum == 0 {
                userOperator = randomOpetators[0]
            } else {
                print("")
            }
            let mathFunction = mathStuffFactory(opString: userOperator)
            let result = mathFunction(firstNum,secNum)
            while guessingLoop {
                print(result)
                print("GUESS THE OPERATION")
                print("")
                guard let answer = readLine() else {
                    print("PLEASE ENTER A VALID OPERATOR")
                    continue
                }
                if answer != userOperator {
                    print("WRONG OPERANT!")
                    print("")
                    print("PLEASE TRY AGAIN")
                    print("")
                    continue
                } else {
                    print("CORRECT!! YOU'VE USED '\(userOperator)'")
                    print("")
                    break
                }
            }
        default:
            guard randomOpetators.contains(components[1]) else {
                print("PLEASE USE THE CORRECT OPERANT")
                continue
            }
            let userOperator = components[1]
            guard let firstNum = Double(components[0]) else {
                print("PLEASE ENTER CORRECT NUMBER")
                continue
            }
            guard let secNum = Double(components[2]) else {
                print("PLEASE ENTER CORRECT NUMBER")
                continue
            }
            let mathFunction = mathStuffFactory(opString: userOperator)
            let result = mathFunction(firstNum,secNum)
            print(result)
            print("YOU'VE USED '\(userOperator)' OPERATOR")
            print("")
        }
        
    case "2":
        print("ENTER YOUR HIGH ORDER OPERATION E.G:")
        print("FILTER 1,2,4,5,6,8 BY < 4")
        guard let userInput2 = readLine() else {
            continue
        }
        let components = userInput2.components(separatedBy: " ")
        print(components)
        
        guard components.count == 5 else {
            print("PLEASE ENTER A CORRECT OPERATION FORMAT!")
            print("")
            continue
        }
        guard words.contains(components[0]) else {
            print("PLEASE ENTER A VALID HIGH OPERATION")
            print("")
            continue
        }
        var intArr = [Int]()
        let stringNums = components[1].components(separatedBy: ",")
        for string in stringNums {
            if let num = Int(string) {
                intArr.append(num)
            }
        }
        guard components[2] == "by" || components[2] ==  "By" else {
            print("PLEASE ENTER A CORRECT FORMAT")
            continue
        }
        guard highOrderOperators.contains(components[3]) else {
            print("INVALID OPERATOR")
            continue
        }
        guard let lastComponent = Int(components[4]) else {
            print("PLEASE ENTER CORRECT NUMBER")
            continue
        }
        switch components[0] {
        case "filter":
            if components[3] == "<" {
                print(myFilter(inputArray: intArr) { (num) -> Bool in
                    return num < lastComponent
                })
            } else if components[3] == ">" {
                print(myFilter(inputArray: intArr) { (num) -> Bool in
                    return num > lastComponent
                })
            } else {
                print("INVALID OPERATION")
                print("")
                continue
            }
            print("")
        case "reduce":
            if components[3] == "*" {
                print(myReduce(arr: intArr, closure: { (num, num2) -> Int in
                    return num * num2
                }, given: lastComponent))
            } else if components[3] == "+" {
                print(myReduce(arr: intArr, closure: { (num, num2) -> Int in
                    return num + num2
                }, given: lastComponent))
            } else {
                print("INVALID OPERATION")
                print("")
                continue
            }
            print("")
        case "map":
            if components[3] == "*" {
                print(customMap(arr: intArr) { (num) -> Int in
                    return num * lastComponent
                })
            } else if components[3] == "/" {
                print(customMap(arr: intArr) { (num) -> Int in
                    return num / lastComponent
                })
            } else {
                print("INVALID OPERATION")
                print("")
                continue
            }
            print("")
        default:
            print("INVALID HIGH OPERATION")
        }
    default:
        print("INVALID")
        
    }
    
    //calculatorIsRunning = false
}

