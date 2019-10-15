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
        imageView.image = UIImage(named: "metallica-hero")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

