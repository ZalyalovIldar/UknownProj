//
//  DetailImageViewController.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 01.03.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func showMoreButtonPressed(_ sender: Any) {
        
        let shareItems = [imageView.image]
        
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        
        present(activityViewController, animated: true, completion: nil)
    }
    
}
