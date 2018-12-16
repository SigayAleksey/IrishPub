//
//  Extensions.swift
//  IrishPub
//
//  Created by Алексей Сигай on 25/11/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIColor {
    // Set color RGB without alpha
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    // Add constraints with VisualFormat
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UITextField {
    // Creating a default UITextField with custom placeholder
    
    static func textFieldWithPlaceholder(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}

extension UIView {
    // Hide Keyboard by tapping the screen
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
    
    @objc private func dismissKeyboard() {
        topSuperview?.endEditing(true)
    }
}

extension UIImageView {
    // Uploading image by URL from JSON
    
    func uploadImageByURL(photoURL: String) {
        
        image = nil
        
        guard let url = URL(string: photoURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }.resume()
    }
}
