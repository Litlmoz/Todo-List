//
//  DetailController.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class DetailController: UIViewController {
    
    @IBOutlet weak var textFieldBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var textFieldCenterY: NSLayoutConstraint!
    @IBOutlet weak var detailTextField: UITextField!
    var item: Item?
    var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let item = item {
            detailTextField.text = item.text
        }
    }
    }
    
    @IBAction func save(_ sender: Any) {
        if let item = item, let newText = detailTextField.text {
            item.text = newText
            context?.saveChanges()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        if let item = item {
            context?.delete(item)
            context?.saveChanges()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo as NSDictionary?,
            let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
                return
        }
        textFieldBottomAnchor.constant = keyboardSize.height
        textFieldCenterY.isActive = false
        textFieldBottomAnchor.isActive = true
        view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        textFieldBottomAnchor.isActive = false
        textFieldCenterY.isActive = true
        view.layoutIfNeeded()
    }
}

@IBDesignable class DetailButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
