//
//  TabBarController.swift
//  IrishPub
//
//  Created by Алексей Сигай on 23/11/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    enum TabBarIcon: String {
        case Welcome = "welcome_icon"
        case Menu = "menu_icon"
        case Event = "event_icon"
        case Beer = "beer_icon"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    func setupTabBar() {
        
        let welcomeNavController = UINavigationController(rootViewController: WelcomeViewController())
        welcomeNavController.title = "Наш паб"
        welcomeNavController.tabBarItem.image = UIImage(named: TabBarIcon.Welcome.rawValue)
        
        let menuNavController = UINavigationController(rootViewController: MenuViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        menuNavController.title = "Меню"
        menuNavController.tabBarItem.image = UIImage(named: TabBarIcon.Menu.rawValue)
        
        let eventNavController = UINavigationController(rootViewController: EventViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        eventNavController.title = "События"
        eventNavController.tabBarItem.image = UIImage(named: TabBarIcon.Event.rawValue)
        
        let beerHistoryNavController = UINavigationController(rootViewController: BeerHistoryViewController())
        beerHistoryNavController.title = "О пиве"
        beerHistoryNavController.tabBarItem.image = UIImage(named: TabBarIcon.Beer.rawValue)

        viewControllers = [welcomeNavController, menuNavController, eventNavController, beerHistoryNavController]
        
        self.tabBar.tintColor = Constant.buttonColor
    }
    
}
