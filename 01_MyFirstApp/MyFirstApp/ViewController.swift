//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Ashesh Singh on 9/6/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func btnClicked(_ sender: Any) {
        if (imageView.image == UIImage(named: "metallica-hero")) {
            imageView.image = UIImage(named: "metallica1")
        } else {
            imageView.image = UIImage(named: "metallica-hero")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

