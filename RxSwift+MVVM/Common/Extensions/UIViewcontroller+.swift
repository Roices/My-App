//
//  UIViewcontroller+.swift
//  RxSwift+MVVM
//
//  Created by Nguyen Anh  Tuan on 21/07/2023.
//

import UIKit

extension UIViewController {
    
    func setupForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillAppear() {
        //Do something here
    }

    @objc func keyboardWillDisappear() {
        //Do something here
    }
}
