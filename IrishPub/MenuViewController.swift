//
//  MenuViewController.swift
//  IrishPub
//
//  Created by Алексей Сигай on 23/11/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit

private let cellId = "MenuCell"

class MenuViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var menu: [Dish]?
    
    let textViewForCellSize: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Меню"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Constant.buttonColor]
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(MenuCell.self, forCellWithReuseIdentifier: cellId)

        menu = fetchData()
    }
    
    func fetchData() -> [Dish]? {
        // Loading data from JSON file to menu array
        
        if let path = Bundle.main.path(forResource: "menu", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonData = try JSONDecoder().decode(ResponseMenu.self, from: data)
                return jsonData.response.items
            } catch {
                print("FetchData Error:\(error)")
            }
        }
        return nil
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        menuCell.dish = menu![indexPath.item]
       
        return menuCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        textViewForCellSize.translatesAutoresizingMaskIntoConstraints = false
        textViewForCellSize.text = menu![indexPath.item].description
        textViewForCellSize.frame = CGRect(x: 0, y: 0, width: (view.frame.width - Constant.menuIndentSide - Constant.menuIndentSide), height: textViewForCellSize.contentSize.height)
        
        let knowHeight: CGFloat = Constant.menuIndentSide + Constant.menuImageHeight + Constant.menuIndentSide
        return CGSize(width: view.frame.width, height: (textViewForCellSize.contentSize.height + knowHeight))
    }
    
}
