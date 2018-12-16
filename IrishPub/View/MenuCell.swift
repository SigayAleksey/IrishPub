//
//  MenuCell.swift
//  IrishPub
//
//  Created by Алексей Сигай on 01/12/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var menuViewController: MenuViewController?
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var dish: Dish? {
        didSet {
            
            if let name = dish?.name {
                nameTextView.text = name
            }
            
            setupImage()
            
            if let price = dish?.price {
                priceLabel.text = numberFormatter.string(from: NSNumber(value: price))
            }
            if let description = dish?.description {
                descriptionTextView.text = description
            }
        }
    }
    
    func setupImage() {
        if let photoURL = dish?.photo {
            photoImageView.uploadImageByURL(photoURL: photoURL)
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Setup View
    
    private func setupView() {
        
        backgroundColor = UIColor.white
        
        addSubview(nameTextView)
        addSubview(photoImageView)
        addSubview(priceLabel)
        addSubview(descriptionTextView)
        
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.menuIndentSide).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.menuIndentSide).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: Constant.menuImageWidth).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: Constant.menuImageHeight).isActive = true
        
        nameTextView.topAnchor.constraint(equalTo: photoImageView.topAnchor).isActive = true
        nameTextView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: Constant.menuIndentSide).isActive = true
        nameTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.menuIndentSide).isActive = true
        nameTextView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        
        priceLabel.widthAnchor.constraint(equalTo: nameTextView.widthAnchor).isActive = true
        priceLabel.centerXAnchor.constraint(equalTo: nameTextView.centerXAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.menuIndentSide).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.menuIndentSide).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: descriptionTextView.contentSize.height)
    }

}
