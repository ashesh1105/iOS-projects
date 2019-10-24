//
//  This project demos how you use classes (OOP) in Swift
//  Musician.swift is a model class which we leverage in this class
//  Musician class uses an Enum MusicianType. SuperMusician inherits from Musician Class
//

import Foundation

// Let's instantiate Musician Class
// To pass enum parameters, you just do a dot(.) and XCode gives you the options to pick from
let james = Musician(name: "James Hetfield", age: 50, instrument: "Guitar", type: .LeadGuitarist)

print("\(james.name)'s name: \(james.name)")
print("\(james.name)'s age: \(james.age)")
print("\(james.name)'s instrument: \(james.instrument)")
print("\(james.name)'s musician type: \(james.type)")
print("\(james.name) sings: \(james.sing())")

// Let's now instantiate from SuperMusician class which inherits from Musician class
let david = SuperMusician(name: "David", age: 40, instrument: "Drum", type: .Drummer)

// Below call to overridden sing method will print both "Nothing else matters..." and "Exit night.."
// since overriden sing method in SuperMusician class calls super.sing() too
print("\(david.name) sings: \(david.sing())")   // prints "Nothing else matters... + Exit light.."

// Below method call on SuperMusician object will call sing2() which is only defined in SuperMusician class
print("\(david.name) sings: \(david.sing2())")  // prints "Enter night.."






