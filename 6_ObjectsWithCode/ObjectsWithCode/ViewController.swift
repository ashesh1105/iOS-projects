//
//  ViewController.swift
//  ObjectsWithCode
//
//  Created by Ashesh Singh on 9/17/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Let's define a new label
    let myLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Why code to have objects and not use Main.storyboard? Because with code we can get screen size of the
        // devise and create objects like buttons, label, etc., accordingly.
        // You can get width and height of user's phone this way
        let phoneWidth = view.frame.size.width
        let phoneHeight = view.frame.size.height
        
        // Decide on size of myLabel
        let myLabelHeightPx = 50    // Taking it as constant
        let myLabelHeight = CGFloat(myLabelHeightPx)  // decide on height of label we want
        // X and Y axis are computd from top left corner of the phone
        let myLabelXAxis = CGFloat(phoneWidth * 0.1)
        let myLabelYAxis = CGFloat(phoneHeight * 0.5 - myLabelHeight/2)
        let myLabelWidth = CGFloat(phoneWidth * 0.8)
        
        // Decorate myLabel and add to Phone view frame
        myLabel.text = "Test Label"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: myLabelXAxis, y: myLabelYAxis, width: myLabelWidth, height: myLabelHeight)
        view.addSubview(myLabel)
        
        // Let's display a button as well via code
        let myButton = UIButton()
        
        // Deciding on size of myButton
        let myButtonHeightPx = 100
        let myButtonWidthPx = 200
        let myButtonHeight = CGFloat(myButtonHeightPx)
        let myButtonWidth = CGFloat(myButtonWidthPx)
        let myButtonXAxis = CGFloat(phoneWidth * 0.5 - myButtonWidth/2)
        let myButtonYAxis = CGFloat(phoneHeight * 0.6 - myLabelHeight/2)
        
        // Decorate myButton and add to Phone view frame
        myButton.setTitle("My Button", for: UIControl.State.normal) // try more options on State, like focussed, etc.
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        myButton.frame = CGRect(x: myButtonXAxis, y: myButtonYAxis, width: myButtonWidth, height: myButtonHeight)
        view.addSubview(myButton)
        
        // Associate an action with this button. self is equivalent to this keyword in Java
        myButton.addTarget(self, action: #selector(ViewController.myAction), for: UIControl.Event.touchUpInside)
    }
    
    // myButton action calls this. Note this must be objectiveC function so annotated with @objc
    @objc func myAction() {
//        print("tapped!")
        // Change the text my myLabel when myButton is clicked
        myLabel.text = "Tapped!"
    }


}

