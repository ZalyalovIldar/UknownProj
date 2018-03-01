//
//  CreateStatementController.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 01.03.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

enum Fields: String {
    case rayoun
    case oblast
    case istecFio
    case istecAddress
    case otvetFio
    case otvetAddress
    case iskTextView
    case askTextView
    
    static let allValues = [rayoun.rawValue, oblast.rawValue,
                            istecFio.rawValue, istecAddress.rawValue,
                            otvetFio.rawValue, otvetAddress.rawValue,
                            iskTextView.rawValue, askTextView.rawValue]
}

class CreateStatementController: UIViewController {
    
    var selectedCategory: String!
    var notificationCenter = NotificationCenter.default
    var isContentSizeHeightChangedWithKeyboard = false
    var userDefaults = UserDefaults.standard
    var pickedImage: UIImage = UIImage()
    
    lazy var dateFormatter: DateFormatter = {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var categoryStackView: UIStackView!
    
    @IBOutlet weak var rayonTF: UITextField!
    @IBOutlet weak var oblastTF: UITextField!
    
    @IBOutlet weak var istecFioTF: UITextField!
    @IBOutlet weak var istecAddressTF: UITextField!
    
    @IBOutlet weak var otvetFioTF: UITextField!
    @IBOutlet weak var otvetAddressTF: UITextField!
    
    @IBOutlet weak var iskTextView: UITextView!
    @IBOutlet weak var askTextView: UITextView!
    
    @IBOutlet var fields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTF.text = selectedCategory
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(self.returnBack))
        let touchGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.returnBack))
        
        categoryTF.addGestureRecognizer(touchGesture2)
        categoryStackView.addGestureRecognizer(touchGesture)
        
        setupKeyboardNotifications()
        obtainSavedFiledsInfo()
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
    
    //MARK: Custom methods
    
    func saveFields(cache: Bool) {
        
        guard cache else {
            for state in Fields.allValues {
                userDefaults.removeObject(forKey: state)
            }
            userDefaults.synchronize()
            return
        }
        
        userDefaults.set(rayonTF.text, forKey: Fields.rayoun.rawValue)
        userDefaults.set(oblastTF.text, forKey: Fields.oblast.rawValue)
        userDefaults.set(istecFioTF.text, forKey: Fields.istecFio.rawValue)
        userDefaults.set(istecAddressTF.text, forKey: Fields.istecAddress.rawValue)
        userDefaults.set(otvetFioTF.text, forKey: Fields.otvetFio.rawValue)
        userDefaults.set(otvetAddressTF.text, forKey: Fields.otvetAddress.rawValue)
        userDefaults.set(iskTextView.text, forKey: Fields.iskTextView.rawValue)
        userDefaults.set(askTextView.text, forKey: Fields.askTextView.rawValue)
        
        userDefaults.synchronize()
    }
    
    func obtainSavedFiledsInfo() {
        
        for (i,state) in Fields.allValues.enumerated() {
            
            guard i < 6 else {
                iskTextView.text = userDefaults.string(forKey: Fields.iskTextView.rawValue)
                askTextView.text = userDefaults.string(forKey: Fields.askTextView.rawValue)
                return
            }
            
            let textField = fields[i]
            textField.text = userDefaults.string(forKey: state)
        }
    }
    
    func saveModel() {
        
        let model = StatementModel(title: iskTextView.text ?? "", image: pickedImage, category: categoryTF.text ?? "", date: dateFormatter.string(from: Date()))
        
        var savedModels = [StatementModel]()
        
        if let decode = UserDefaults.standard.object(forKey: "data") as? Data {
            
            savedModels = NSKeyedUnarchiver.unarchiveObject(with: decode) as! [StatementModel]
            savedModels.append(model)
        }
        else {
            savedModels.append(model)
        }
       
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: savedModels)
       
        userDefaults.set(encodedData, forKey: "data")
        userDefaults.synchronize()
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
    
    @objc
    func returnBack() {
        saveFields(cache: true)
        navigationController?.popViewController(animated: true)
    }

    
    //MARK: Buttons actions
    
    @IBAction func addFilesPressed(_ sender: Any) {

    }
    
    @IBAction func sendStatementPressed(_ sender: Any) {
        saveModel()
        saveFields(cache: false)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didPressCancel(_ sender: Any) {
        
        saveFields(cache: false)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
