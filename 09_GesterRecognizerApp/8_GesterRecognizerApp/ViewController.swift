//
//  ViewController.swift
//  8_GesterRecognizerApp
//
//  This project demos adding gesture recognizers to UI elements like Image View
//  and implement some actions based on them. That way any UI element can be added a
//  gester recognizer and you aren't dependent on a button alone for action based events
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    var raniPic1 = true // So we can alternate beween two Rani pics on image view taps
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // An important step to enable interaction for a UI Element
        myImageView.isUserInteractionEnabled = true
        
        // Create a gester recognizer which takes a objective c method to run
        let gesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        
        // Add the gester recognizer to your UI element
        myImageView.addGestureRecognizer(gesterRecognizer)
    }
    
    @objc func changePic() {
        
        // Alternate the pic that displays on Image View
        if raniPic1 {
            myImageView.image = UIImage(named: "rani_mukherjee2")
            myLabel.text = "Rani Mukherjee Image #2"
            raniPic1 = false
        } else {
            myImageView.image = UIImage(named: "rani_mukherjee1")
            myLabel.text = "Rani Mukherjee Image #1"
            raniPic1 = true
        }
    }


}

