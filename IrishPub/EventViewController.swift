//
//  EventViewController.swift
//  IrishPub
//
//  Created by Алексей Сигай on 06/12/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit

private let cellId = "EventCell"

class EventViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var events: [Event]?
    
    let textViewForCellSize: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "События"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Constant.buttonColor]
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(EventCell.self, forCellWithReuseIdentifier: cellId)
        
        events = fetchData()
    }
    
    func fetchData() -> [Event]? {
        // Loading data from JSON file to events array
        
        if let path = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonData = try JSONDecoder().decode(ResponseEvents.self, from: data)
                return jsonData.response.items
            } catch {
                print("FetchData Error:\(error)")
            }
        }
        return nil
    }    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventCell
        
        eventCell.event = events![indexPath.item]
        
        return eventCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        textViewForCellSize.translatesAutoresizingMaskIntoConstraints = false
        let widthOfContent = self.view.frame.width - Constant.menuIndentSide - Constant.menuIndentSide
        
        let heightOfHeadline: CGFloat = {
            self.textViewForCellSize.text = self.events![indexPath.item].headline
            self.textViewForCellSize.font = UIFont.boldSystemFont(ofSize: 20)
            self.textViewForCellSize.sizeToFit()
            self.textViewForCellSize.frame = CGRect(x: 0, y: 0, width: widthOfContent, height: textViewForCellSize.contentSize.height)
            return self.textViewForCellSize.frame.height
        }()
        let heightOfPhoto: CGFloat = (view.frame.width - Constant.menuIndentSide - Constant.menuIndentSide) * 0.5
        let heightOfDescription: CGFloat = {
            self.textViewForCellSize.text = self.events![indexPath.item].description
            self.textViewForCellSize.font = UIFont.systemFont(ofSize: 14)
            self.textViewForCellSize.sizeToFit()
            self.textViewForCellSize.frame = CGRect(x: 0, y: 0, width: widthOfContent, height: textViewForCellSize.contentSize.height)
            return self.textViewForCellSize.frame.height
        }()
        
        return CGSize(width: view.frame.width, height: (heightOfHeadline + heightOfPhoto + heightOfDescription + 30))
    }
    
}
