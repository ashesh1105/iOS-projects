//
//  ViewController.swift
//  WorstCalculatorEver
//
//  Created by Ashesh Singh on 9/16/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func sumClicked(_ sender: Any) {
        
        // You can force unwrap like below but app will crash if input is not text
        // First ! => hey Swift, know that firstText will definitely has value
        // Second ! => hey swift, don't worry, I am sure the data there is an Int wrapped as text
//        let firstNumber = Int(firstText.text!)!
//        let secondNumber = Int(secondText.text!)!
//        let result = firstNumber + secondNumber
//        resultLabel.text = String(result)
        
        // Best way is to use if let statement in this case, where you can do error handling too
        if let firstNumber = Int(firstText.text!) {
            if let secondNumber = Int(secondText.text!) {
                result = firstNumber + secondNumber
                resultLabel.text = String(result)
            }
        }   // You can do an else here and display error message on app
        
    }
    @IBAction func minusClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!) {
            if let secondNumber = Int(secondText.text!) {
                result = firstNumber - secondNumber
                resultLabel.text = String(result)
            }
        }
    }
    @IBAction func multiplyClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!) {
            if let secondNumber = Int(secondText.text!) {
                result = firstNumber * secondNumber
                resultLabel.text = String(result)
            }
        }
    }
    @IBAction func divideClicked(_ sender: Any) {
        if let firstNumber = Int(firstText.text!) {
            if let secondNumber = Int(secondText.text!) {
                result = firstNumber / secondNumber
                resultLabel.text = String(result)
            }
        }
    }
    

}

