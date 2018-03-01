//
//  StatementCell.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 28.02.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class StatementCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stateImageView: UIImageView!
    
   
    func configureCell(with model: StatementModel) {
        
        titleLabel.text = model.title
        typeLabel.text = model.category
        dateLabel.text = model.date
        stateImageView.image = model.image
    }
}
