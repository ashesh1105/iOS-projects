//  BirthdayNoteTaker
//
//  This project will demonstrate the use of small key-value store called UserDefaults to persist the user data
//  between app runs (view load)

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is how you can restore data from UserDefaults which is a small key-value store
        // Note, the data will be retrieved as Any type, which will need casting
        let nameFromSmallKVStore = UserDefaults.standard.object(forKey: "name")
        let birthdayFromSmallKVStore = UserDefaults.standard.object(forKey: "birthday")
        
        
        // Casting Optional as? or Forced Unwrap as!
        // Best to use if let in this case with optional
        if let newName = nameFromSmallKVStore as? String {
            nameLabel.text = "Name: \(newName)"
        }
        
        if let newBirthdate = birthdayFromSmallKVStore as? String {
            birthdayLabel.text = "Brithdate: \(newBirthdate)"
        }

    }

    // Persist the data when save button is clicked
    @IBAction func saveButton(_ sender: Any) {
        
        // UserDefaults can be used as a small key-value store, not when we need to save many variables and data
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.set(birthdayTextField.text, forKey: "birthday")
        
        // Its okay to force unwrap in this case (by !) instead of going for optionals or default value since
        // text fields will definitely have at least an empty string
        nameLabel.text = "Name: \(nameTextField.text!)"
        birthdayLabel.text = "Birthday: \(birthdayTextField.text!)"
    }
    
    // Delete the persisted data when delete button is clicked
    @IBAction func deleteBtnClicked(_ sender: Any) {
        
        // Ensure you call removeObject on UserDefaults only if key - value pair exists!
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthdate = UserDefaults.standard.object(forKey: "birthdate")
        
        // We don't need if - let here since we will call removeObject where we do not need new (casted) variable
        if (storedName as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name: "
        }
        
        if (storedBirthdate as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "birthdate")
            birthdayLabel.text = "Birthday: "
        }
        
        nameLabel.text = "Name: \("")"
        birthdayLabel.text = "Birthdate: \("")"
        
    }
    
}

