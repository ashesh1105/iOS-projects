//
//  main.swift
//  Loops
//
//  Created by Ashesh Singh on 9/15/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import Foundation

// While Loop
var num1 : Int = 1  // can also do var num1 = 1 and swift will infer the type to be Int
// Below loop will print 0 to 9. Note the operator ++ is not allowed in Swift but += is allowed
while num1 <= 10 {   // can also do while (num1 < 10) {
    print(num1)
    num1 += 1
}

// For Loop
var myFruitArray = ["Banana", "Apple", "Orange"]
// Below for loop will print the tree elements in above array
for fruit in myFruitArray {
    print(fruit)
}

var myNumbers = [10, 20, 30, 40, 50, 60]
for num in myNumbers {
    print(num / 5)
}   // will print 2, 4, 6, 8, 10, 12

// Can get numbers in a custom range with ... operator
for myNewInt in 1...5 {
    print(myNewInt * 5)
}

// if-else with strings can leverage == operator in Swift
var name = "David"
if name == "david" {
    print(name)
} else {
    print("Ashesh")
}   // Will print Ashesh since "David" != "david"


