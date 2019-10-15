//
//  main.swift
//  macOS_CommandLineTools_Project
//
//  Created by Ashesh Singh on 9/15/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import Foundation

// You can use this to test any swift code. Playground project can be used as well
var str = "Hello, World!"
print(str)  // prints "Hello World!"

// String data type has methods we can use, like other languages
str.append("!!")    // appends the character(s) at the end and changes original variable now holds new value
print(str)  // now prints "Hello World!!!"
print(str.lowercased()) // prints "hello, world!!!"
print(str)  // lowercased method does not change the original string, so this line still prints "Hello World!!!"
print(str.uppercased()) // prints "HELLO, WORLD!!!"

// Swift uses camel case for naming variables
var myNumber = 4 * 5
print(myNumber)

// Constants are defined using let keyword. Once defined you can not change them
let userAge = 25
// userAge = 28 => you'll get an error: "Cannot assign to value: 'userAge' is a 'let' constant"
// You can, however, use the constants once defined, as below
print(myNumber + userAge)   // will print 45

// Operations can't involve variables of different types
let pi = 3.14
// print(userAge * pi)  => will be an error: "Binary operator '*' cannot be applied to operands of type 'Int' and 'Double'"
// How do you get around this?

// intger, double and float
let numConst = 4
print(userAge / numConst)   // prints 6, why? since userAge is 25 and numConstant1 is 4, both are integers so result is integer too

let myNumberD = 50.0
let numConstD = 4.0
print(myNumberD / numConstD)    // Now it prints 12.5, which is correct. Since both the operands are double, result is in double!

// Once you assign a variable, you can not assign value of another type:
// myNumber = 23.0 => Will be an error: "Cannot assign value of type 'Double' to type 'Int'"

// Defining and Initializing a Swift varible can be different in separate steps or same one
var userName : String   // defining a variable to type String
userName = "david"  // initializing the variable
print(userName) // prints "david"

let num1 : Int = 5  // define and initialize a constant of Int type in same step
print(num1) // prints 5





