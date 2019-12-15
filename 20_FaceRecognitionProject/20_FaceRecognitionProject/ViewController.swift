/*
 FaceRecognitionProject: Only the user authorized to see second view, will see it!
 1) Get two view controller, one has button to sign in and a label to display any error. Another one just a label that says sign in. Once user is able to sign in successfully, we will take the user to second view.
 2) Drag the controls in first view to view controller, where we will do segue.
 3) For Face Recognition, import LocalAuthentication in ViewController class
 4) In the signInClicked method, add the code needed for FaceRecognition. Check that method for inline comments.
 5) We need a new attribute in info.plist as Privacy - Face ID Usage Description with value as what you need, say "To Authenticate"
 6) Run the app, ensure in the simulated app context, Hardware -> Face ID -> Enrolled is selected. Click on button where it looks for matching face id. Simulate this by going to Hardware -> Face ID - Matching Face. You'll see an error at this stage. See next step for the reason for this error and to resolve this.
 7) If you go back to your code where you performSegue when FaceRecognition is successful, you'll see the error in purple text: "UIViewController.performSegue(withIdentifier:sender:) must be used from main thread only"
    This means we should never perform segue from inside a closure (background thread). How do we fix this
    error? Click on the question mark that is displayed with error to see Swift documentation. Solution is
    to pass a message to main thread to run the code we need using DispatchQueue.main.async {}. Check the
    updated code in our case to see this in action!
 */

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        let authContext = LAContext()
        
        // Check if this iphone is capable of doing Face Recognition
        // In canEvaluatePolicy method below, we need an NSError Pointer that needs to be
        // created first. Also in that method, we need to indicate that we are specifying a pointer so
        // & needs to be appeded before error NSObject
        var error: NSError? // Since we aren't initiatizing it, this needs to be optional
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            // Now we can evaluate the policy itself, meaning calling this for an action
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                if success {
                    // successful auth. Need self to be prefixed since we are inside a closure here
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
            
        }
        
        
        
    }
    
}

