//
//  SuperMusician class inherits from Musician Class
//

import Foundation

class SuperMusician: Musician {
    
    func sing2() -> String {
        return "Enter night.."
    }
    
    // Since sing is defined in Parent method, you must use override keyword, else it'll be an error
    override func sing() -> String {
        let result1 = super.sing()
        return "\(result1) + Exit light.."
    }
    
}
