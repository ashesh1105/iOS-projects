//
// This project demos creating and adding an alert to a view controller, in this case represented by "self" keyword
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
        
        var alertTitle = ""
        var alertErrorMsg = ""
        
        // Populate alert title and appropriate error message for alert in case an issue in user input
        if userNameText.text == "" {
            alertTitle = "Username Error!"
            alertErrorMsg = "User name can not be empty!"
        } else if passwordText.text == "" {
            alertTitle = "Password Error!"
            alertErrorMsg = "Password can not be empty!"
        } else if passwordAgainText.text == "" {
            alertTitle = "Password Error!"
            alertErrorMsg = "Second time password can not be empty!"
        } else if passwordText.text != passwordAgainText.text {
            alertTitle = "Password Mismatch Error!"
            alertErrorMsg = "Given passwords do not match!"
        }
        
        // Custom function to generate alert
        generateAlert(myTitle: alertTitle, errorMsg: alertErrorMsg)
    }
    
    // Our generic function to generate an alert based on parameters we provide it
    func generateAlert(myTitle: String, errorMsg: String) {
        
        // Create an alert this way. You have other options as well to chose from on UIAlertController.Style.Style
        // Style.alert show a regular alert. Style.actionSheet show the popup at the bottom of the app, different look and feel
        let alert = UIAlertController(title: myTitle, message: errorMsg, preferredStyle: UIAlertController.Style.actionSheet)
        
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

