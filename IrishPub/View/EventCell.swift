//
//  EventCell.swift
//  IrishPub
//
//  Created by Алексей Сигай on 08/12/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    var eventViewController: EventViewController?

    let headlineTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.sizeToFit()
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.sizeToFit()
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    var event: Event? {
        didSet {
            
            if let headline = event?.headline {
                headlineTextView.text = headline
            }
            
            setupImage()

            if let description = event?.description {
                descriptionTextView.text = description
            }
            if let eventDate = event?.date {
                dateLabel.text = dateFormatter.string(from: eventDate)
            }
        }
    }
    
    func setupImage() {
        if let photoURL = event?.photo {
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
        
        addSubview(headlineTextView)
        addSubview(photoImageView)
        addSubview(descriptionTextView)
        addSubview(dateLabel)
        
        headlineTextView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let heightOfPhoto: CGFloat = (self.frame.width - Constant.menuIndentSide - Constant.menuIndentSide) * 0.5
        
        addConstraintsWithFormat(format: "V:|[v0][v1(\(heightOfPhoto))][v2][v3]-10-|", views: headlineTextView, photoImageView, descriptionTextView, dateLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: headlineTextView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: photoImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: descriptionTextView)
        addConstraintsWithFormat(format: "H:[v0]-40-|", views: dateLabel)
    }
    
}
