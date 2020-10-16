import UIKit

var str = "Hello, playground"

10 * 5
var myNumber = 5*4
myNumber * 20

str.append(". Let's play!")
str = str.lowercased()
str = str.uppercased()

// Constants are defined using let keyword. Once defined you can not change them
let userAge = 25
// userAge = 28 => you'll get an error: "Cannot assign to value: 'userAge' is a 'let' constant"
// You can, however, use the constants once defined, as below
print(myNumber + userAge)   // will print 45

// Operations can't involve variables of different types
let pi = 3.14
// If you do not typecast it, you'll get an error: "Binary operator '*' cannot be applied to operands of type 'Int' and 'Double'"
var result: Double = Double(userAge) * pi

// New variable declaration is not necessary, especially in playgroud here or using it in code somewhere
Double(userAge) * pi








