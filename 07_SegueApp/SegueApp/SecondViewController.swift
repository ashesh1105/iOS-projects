//
//  SecondViewController.swift
//  SegueApp
//
//  Created by Ashesh Singh on 9/24/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var titleLabelSecondViewController: UILabel!
    @IBOutlet weak var nameLabelSecondVC: UILabel!
    
    // Below will be accessed in first view controller inside prepare method via segue from ViewController -> SecondViewController
    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabelSecondVC.text = "Welcome \(myName)!"
    }
    
}
