//
//  ViewController.swift
//  8_GesterRecognizerApp
//
//  This project demos adding gesture recognizers to UI controlls like Image View
//  and implement some actions based on them. That way any control can be added a
//  gester recognizer and you aren't dependent on a button alone for action based events
//
//  Created by Ashesh Singh on 9/27/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    var raniPic1 = true // So we can alternate beween two Rani pics on image view taps
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView.isUserInteractionEnabled = true
        let gesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        myImageView.addGestureRecognizer(gesterRecognizer)
    }
    
    @objc func changePic() {
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

