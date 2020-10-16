// Swift Fundamentals: Functions, Arrays, Set and Dictionary
// Note, This is MacOS Project so this file can be run as standalone program from XCode

import Foundation

var myStrArr = ["str1", "str2", "str3", "str4"]
print(myStrArr[1])  // prints str2

// Arrays can store elements of specific type, you are not allowed to mix them unless using Any type
// var myArr = ["abc", "xyz", 2]    => Error: "Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional"
// Types can be mixed if we use Any type:
var myArrAnyType = ["abc", "xyz", 2, true] as [Any]
print(myArrAnyType[2])  // prints 2
print(myArrAnyType[3])  // prints true

// Some of Arrays methods demo
print("Some Array methods demo:")
myStrArr.append("str5") // appends "str5" to end of array
print(myStrArr) // prints ["str1", "str2", "str3", "str4", "str5"]
print(myStrArr.capacity)    // prints 8
print(myStrArr.count)   // prints 5
print(myStrArr.endIndex)    // prints 5. This is confusing, last index should be 1 less than count of elements. TODO: Find more details!
// print(myStrArr[myStrArr.endIndex])   => This will be an error since myStrArr[5] will mean array has to has at least 6 elements, it only has 5!
myStrArr.sort()     // sorts the array
print(myStrArr)     // prints: ["str1", "str2", "str3", "str4", "str5"]
myStrArr.reverse()  // Array gets reversed, original array changed.
print(myStrArr) // prints array in reverse order: ["str5", "str4", "str3", "str2", "str1"]
print("myStrArr.contains('str2'): \(myStrArr.contains("str2"))")    // prints true
print(myStrArr.first)   // prints Optional("str5") with a warning: "Expression implicitly coerced from 'String?' to 'Any'"
print(myStrArr.last!)    // prints str1 with no warning since we are force unwrapping in this case


// Sets are unordered collections which do not allow duplicates
var mySet : Set = [1, 2, 3, 4, 5]
mySet.insert(5) // Swift ignores this command since 5 is already present in the set
print(mySet)    // prints same set in random order: [4, 5, 3, 2, 1]
mySet.insert(7) // inserts 7 to set
print(mySet)    // prints set with 7 added in it: [4, 1, 7, 3, 5, 2]
// Sets don't have the notion of "Index" since they are unordered collection!!
// Meaning if you do mySet[0], that will be an error!
// print(mySet[0])  => Error: "Cannot subscript a value of type 'Set<Int>' with an argument of type 'Int'"

// Removing dups from an array by using a set
var myIntArr = [1, 2, 3, 4, 5, 2, 3, 6, 8, 9, 5, 3, 8]  // Int array with duplicates
var myIntSet = Set(myIntArr)
print(myIntSet) // prints set with elements from myIntArr but with no duplicates, in unordered way

// Union of Sets
var mySet1 : Set = [1, 2, 3]
var mySet2 : Set = [3, 4, 5]
var mySet3 : Set = mySet1.union(mySet2)
print(mySet3)   // prints elements from two sets but without duplicates, unordered way, e.g.,: [2, 3, 1, 4, 5]


// Dicrionaries in Swift are like maps in other languages. Involves key-value pairs
var myFavouriteDirectors = [
    "Pulp Fiction": "Tarantino",
    "Lock Stock": "Guy Ritchie",
    "The Dark Knight": "Christopher Nolan"
]
print(myFavouriteDirectors["Lock Stock"])   // Prints Optional("Guy Ritchie"). Add ! to get rid of Optional (TODO: Explore more on Optional results)
myFavouriteDirectors["The Dark Knight"] = "Ashesh Singh"
print(myFavouriteDirectors["The Dark Knight"]!)  // Prints the new value with this key
// Another example of dictionary
var myCaloriesBurnt = [
    "Run": 100,
    "Swim": 200,
    "Basketball": 300
]
print(myCaloriesBurnt["Swim"]!)  // prints 200, the value of key "swim". Does not say Optional since we're force unwrapping it




