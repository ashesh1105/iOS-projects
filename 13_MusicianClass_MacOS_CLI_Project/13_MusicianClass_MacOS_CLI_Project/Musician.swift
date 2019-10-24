//
//  Musician class will be our model
//

import Foundation

enum MusicianType {
    case LeadGuitarist
    case Vocalist
    case Drummer
    case Bassist
    case Violinist
}

class Musician {
    
    // Attributes or Properties of this class
    var name: String
    var age: Int
    var instrument: String
    var type: MusicianType
    
    // init in Swift is like Constructors in other programming languages
    init(name: String, age: Int, instrument: String, type: MusicianType) {
        self.name = name
        self.age = age
        self.instrument = instrument
        self.type = type
    }
    
    func sing() -> String {
        return "Nothing else matters..."
    }
    
    //
    
}
