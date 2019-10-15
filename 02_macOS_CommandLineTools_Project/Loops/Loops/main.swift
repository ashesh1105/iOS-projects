// Demo of Loops of various kinds in Swift
// MacOS Project. This file can be run as stand alone program in XCode

import Foundation

// While Loop
var num1 : Int = 1  // can also do var num1 = 1 and swift will infer the type to be Int
// Below loop will print 1 to 10. Note the operator ++ is not allowed in Swift but += can be used
while num1 <= 10 {   // can also do while (num1 < 10) {
    print(num1)
    num1 += 1
}

// For Loop
var myFruitArray = ["Banana", "Apple", "Orange"]
// Below for loop will print the three elements in above array
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
}   // prints 5, 10, 15, 20, 25

// if-else loop with strings can leverage == operator in Swift
var name = "David"
if name == "david" {
    print(name)
} else {
    print("Ashesh")
}   // Will print Ashesh since "David" != "david"


