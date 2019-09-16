//  main.swift
//  Function in Swift
//  Created by Ashesh Singh on 9/15/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import Foundation

func myFunction() {
    print("Hello")
}
myFunction()    // calls myFuction and prints "Hello"

// Note, this function does not return anything
func add(x : Int, y : Int) {
    print (x + y)
}
add(x: 8, y: 5) // prints 13. Note, you must specify the argument names when passing their values

// This function does return a value, the sum of arguments passed
func addUs(x: Int, y: Int) -> Int {
    return x + y
}
print(addUs(x: 4, y: 7))    // prints 11

// Return a boolean
func isGreater(x: Int, y: Int) -> Bool {
    return x > y
}
print(isGreater(x: 8, y: 3))    // prints true

// Return a String
func toUpper(str: String) -> String {
    return str.uppercased()
}
print(toUpper(str: "ashesh"))   // prints ASHESH



