//
//  DetailedViewController.swift
//  11_LandmarkBook
//
//  Created by Ashesh Singh on 10/14/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

// Segue is established from ViewController to DetailedViewController
class DetailedViewController: UIViewController {

    @IBOutlet var detailedImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailedViewLabel: UILabel!
    
    // Define variables to get data from main view controller when user taps on one of the tableview rows
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the label and image as passed on from main view controller via segue
        detailedViewLabel.text = selectedLandmarkName
        imageView.image = selectedLandmarkImage
    }
}
