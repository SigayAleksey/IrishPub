//
//  BeerHistoryViewController.swift
//  IrishPub
//
//  Created by Алексей Сигай on 23/11/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit

class BeerHistoryViewController: UIViewController {
    
    let plugTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Скоро здесь появятся статьи об истории пива"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textAlignment = .center
        textView.sizeToFit()
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let smileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "smile_image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(answer), for: .touchUpInside)
        button.tintColor = Constant.buttonColor
        button.setTitle("Уже хочу почитать!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "О пиве"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Constant.buttonColor]
        
        setupView()
    }
    
    // Send information
    @objc private func answer() {
        
        showAlert()

        // Send information to server
    }
    func showAlert() {
        let alert = UIAlertController(title: "Благодарим за Ваше мнение!", message: "Мы рады любознательности наших посетителей и тщательно работаем над подборкой самый интересных статей", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }   

    
    // MARK: - Setup View
    
    private func setupView() {
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(plugTextView)
        view.addSubview(smileImageView)
        view.addSubview(likeButton)
        
        let fourthViewHeight: CGFloat = view.frame.height / 4
        
        plugTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: fourthViewHeight - 50).isActive = true
        plugTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        plugTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        plugTextView.heightAnchor.constraint(equalToConstant: plugTextView.contentSize.height)
        
        smileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        smileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        smileImageView.heightAnchor.constraint(equalToConstant: 150) .isActive = true
     
        likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(fourthViewHeight - 50)).isActive = true
    }

}
