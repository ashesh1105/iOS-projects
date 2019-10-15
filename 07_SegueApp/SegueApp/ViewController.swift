//
//  ViewController.swift
//  SegueApp: Segue meaning connection between first view controller to second one.
//  This app demostrates segue using Main.storyboard (done visually) as well as via code.
//  When you ctrl + drag from one view controller to another in Main.storyboard, you create a link between them.
//  That link is the identifier (you can give it a name there) that is used in performSegue and prepare methods
//  to make connection between view controller in the code and exchange data between them.

//  This project also demonstrates View Controller Lifecycle Methods as can be seen on this View Controller class itself.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabelFirstViewController: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    
    // Define a global variable to handle user input added in first View Controller
    var userName = ""
    
    // Called only once when app gets loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // print statement to show ViewController Lifecycle Method call sequence
        print("viewDidLoad function called")
        
        // Below code won't have any affect when you go back to this view from previous one since viewDidLoad gets called only once!
        // Right lifecycle function to put this code to so myLabel gets reset will be viewWillAppear() which is called whenever control comes back to this VC
        nameLabel.text = ""
    }
    
    // This is the button which, in our example, brings in new view controller where we need data from first VC
    @IBAction func nextButton(_ sender: Any) {
        
        // Set user input to our global variable
        userName = nameLabel.text!
        
        // Below does segue from code, similar to how we do visually from Main.storyboard between two view controllers
        // sequeFirstVCToSecond is unique id for segue we created in Main.storyboard by ctrl + dragging from one
        // View Controller to another.
        performSegue(withIdentifier: "sequeFirstVCToSecond", sender: nil)
    }
    
    // Below overridden method allows prepping up to share data between two view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeFirstVCToSecond" {
            // as! casting
            let destinationVC = segue.destination as! SecondViewController
            
            // myName should autopopulate with a dot on variable destinationVC we created above as long as it esists as global variable in
            // second view controler - SecondViewController. We set that variable with user input from first view controller
            destinationVC.myName = userName
        }
    }
    
    /*
     More of View Controller Life Cycle Methods below
     */
    // Called again and again before view appears
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = "" // So when you go back to this view controller, previous text is gone
        print("viewWillAppear function called")
    }
    
    // Called again and again after view appears
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear function called")
    }
    
    // Called again and again before view disappears
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear function called")
    }
    
    // Called again and again whenever view disappears
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear function called")
    }
    
}

