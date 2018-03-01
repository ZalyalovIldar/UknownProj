//
//  StatementDetailController.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 01.03.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class StatementDetailController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var model: StatementModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleLabel.text = model.title
        categoryLabel.text = model.category
        dateLabel.text = model.date
        imageView.image = model.image
    }

    @IBAction func moreButtonPressed(_ sender: Any) {
        
        
    }
}
