//
//  StatementModel.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 28.02.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import Foundation
import UIKit

/// Модель заявления
class StatementModel: NSObject, NSCoding {
    
    var title: String
    var image: UIImage
    var category: String
    var date: String
    
    init(title: String, image: UIImage, category: String, date: String) {
        
        self.title = title
        self.image = image
        self.category = category
        self.date = date
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(title, forKey: "title")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(date, forKey: "date")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
       
        let title =  aDecoder.decodeObject(forKey: "title") as! String
        let image =  aDecoder.decodeObject(forKey: "image") as! UIImage
        let category =  aDecoder.decodeObject(forKey: "category") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String
        
        self.init(title: title, image: image, category: category, date: date)
    }
}
