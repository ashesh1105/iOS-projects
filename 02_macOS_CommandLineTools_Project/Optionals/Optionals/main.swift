import Foundation

/*
 Optionals help prevent iOS apps from crashing.
 When we unpack a data and typecast to another data type, Swift allows us to handle that situation in 4 different ways:
 1) ? => Optional, where we speficy that there are chances data in one type may not be as we need it, e.g., characters instead of numbers,
 2) ! => We force unwrap and tell Swift that we know the data we are unwraping is how we think it is, so go ahead and do it.
 3) ?? <default value> => Here we speficy a default value in case the data is not the way we need it, e.g. characters instead of numbers,
 4) if let - else => Here we specify code to run incase data is the desired one, else part handles the error
 In abobe, 1) and 2) do not help app from crashing if we get surprizes but 3) and 4) do
 */

// 1) If you uncomment and run below two lines of code, you get error: "Variable 'myName' used before being initialized". App will crash
//var myName : String
//myName.uppercased()

// This is how you can take care of above situation. You will get nil results but app won't crash
var myName : String?    // ? with datatype is needed so we can use optional in the line below. This is called Optional Chaining
print(myName?.uppercased()) // prints nil with a warning: "Expression implicitly coerced from 'String?' to 'Any'"

// 2) Where you're certain the underlying data is correct (like Int, for example), you can force unwrap using ! operator
// Note here that if num1 did not has number in there (e.g., "ce"), app will crash
var num1 = "5"
// if you remove the ! mark below, you'll get an error: "Value of optional type 'Int?' must be unwrapped to a value of type 'Int'"
var product = Int(num1)! * 5
print(product)  // prints 25

// 3) ?? <default value> example
var myAge = "rr"
// If you remove ?? default operator below, you get an error: "Value of optional type 'Int?' must be unwrapped to a value of type 'Int'"
var catAge = (Int(myAge) ?? 0) * 7
print(catAge)   // prints 0 with no error and app does not crash

// 4) if let example
// In below example, app won't crash and prompts the user to enter a number, so we can use this to compute the results or do error handling too!
if let myNumber = Int(myAge) {
    print("A number was passed to myAge! Computing cat age:")
    print(myNumber * 7)
} else {
    print("Please enter a number to compute cat age!")
}   // Since myAge as "rr" being passed above, you get to else block and see: "Please enter a number to compute cat age!" being printed.


