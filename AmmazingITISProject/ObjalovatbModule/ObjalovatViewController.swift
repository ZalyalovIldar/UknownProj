//
//  ObjalovatViewController.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 01.03.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class ObjalovatViewController: UIViewController {
    
    var notificationCenter = NotificationCenter.default
    var isContentSizeHeightChangedWithKeyboard = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupKeyboardNotifications()
    }
    
    func setupKeyboardNotifications() {
        
        notificationCenter.addObserver(self,
                                       selector: #selector(self.keyboardWillShow(with:)),
                                       name: NSNotification.Name.UIKeyboardWillShow,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(self.keyboardWillHide(with:)),
                                       name: NSNotification.Name.UIKeyboardWillHide,
                                       object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc
    func keyboardWillShow(with notification: Notification) {
        
        guard let info = notification.userInfo,
            let keyboardEndSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
            else { return }
        
        guard !isContentSizeHeightChangedWithKeyboard else { return }
        
        isContentSizeHeightChangedWithKeyboard = true
        
        scrollView.contentSize.height += keyboardEndSize.height
        
        var insets = scrollView.scrollIndicatorInsets
        insets.bottom += keyboardEndSize.height
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc
    func keyboardWillHide(with notification: Notification) {
        
        guard let info = notification.userInfo,
            let keyboardEndSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
            else { return }
        
        isContentSizeHeightChangedWithKeyboard = false
        
        scrollView.contentSize.height -= keyboardEndSize.height
        
        var insets = scrollView.scrollIndicatorInsets
        insets.bottom -= keyboardEndSize.height
        scrollView.scrollIndicatorInsets = insets
    }

}
