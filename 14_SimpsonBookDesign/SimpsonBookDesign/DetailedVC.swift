//
//  DetailedVC.swift
//  SimpsonBookDesign
//
//  Created by Ashesh Singh on 10/24/19.
//  Copyright © 2019 Ashesh Singh. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    // Mark it as optional type. We initialize it from ViewController when user clicks on a row
    var selectedSimpson : Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedImageView.image = selectedSimpson!.image
        nameLabel.text = selectedSimpson!.name
        jobLabel.text = selectedSimpson!.job

    }

}
