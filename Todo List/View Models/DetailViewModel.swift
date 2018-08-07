//
//  DetailViewModel.swift
//  Todo List
//
//  Created by David Solis on 8/7/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit

extension DetailController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - PickerView Delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let _ = item {
            switch pickerDataSource[row] {
            case "Green":
                item?.color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).encode()
                view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            case "Blue":
                item?.color = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).encode()
                view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            case "Purple":
                item?.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).encode()
                view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            case "":
                item?.color = nil
                view.backgroundColor = .white
            default:
                break
            }
            context.saveChanges()
        }
    }
    
    // MARK: - Helpers
    
    func selectPickerViewFor(_ item: Item) {
        if let colorData = item.color {
            let color = UIColor.color(withData: colorData)
            view.backgroundColor = color
            switch color {
            case #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1):
                backgroundColorPicker.selectRow(1, inComponent: 0, animated: false)
            case #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1):
                backgroundColorPicker.selectRow(2, inComponent: 0, animated: false)
            case #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1):
                backgroundColorPicker.selectRow(3, inComponent: 0, animated: false)
            default:
                break
            }
        }
    }
}

extension DetailController {
    
    // MARK: - Keyboard Observers
    
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

extension UIColor {
    
    class func color(withData data: Data) -> UIColor {
        return try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)!
    }
    
    func encode() -> Data {
        return try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
