//
//  ViewController.swift
//  AlertMessages
//
//  Created by Ashesh Singh on 9/26/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text == "" {
            generateAlert(myTitle: "Username Error!", errorMsg: "User name can not be empty!")
        } else if passwordText.text == "" {
            generateAlert(myTitle: "Password Error!", errorMsg: "Password can not be empty!")
        } else if passwordAgainText.text == "" {
            generateAlert(myTitle: "Password Error!", errorMsg: "Second time password can not be empty!")
        } else if passwordText.text != passwordAgainText.text {
            generateAlert(myTitle: "Password Mismatch Error!", errorMsg: "Given passwords do not match!")
        }
    }
    
    // Our generic function to generate an alert based on parameters we provide it
    func generateAlert(myTitle: String, errorMsg: String) {
        
        // Create an alert this way. You have other options as well to chose from on UIAlertController.Style.Style
        let alert = UIAlertController(title: myTitle, message: errorMsg, preferredStyle: UIAlertController.Style.alert)
        
        // You must create an action and associate that with your alert, else alert will just sit there and you can't even dismiss that!
        // Note, with your action, you get a handler, which is a function that is called when this action happens, we are printing into log here
        // but you can do anything else if you want. Also, there are multiple styles to chose from on UIAlertAction.Style as well
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            // button clicked
            print("alert button clicked for error: \(errorMsg)")
        }
        alert.addAction(okButton)
        
        // Finally add the alert to your view controller
        self.present(alert, animated: true, completion: nil)
    }
    
}

