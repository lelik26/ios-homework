//
//  TabBarController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile
    
        
        var title: String {
            switch self {
            case .feed:
                return "Лента пользователя"
            case .profile:
                return "Профиль пользователя"
          
            }
        }
        
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house") // установка значка дом (лента пользователя)
            case .profile:
                return UIImage(systemName: "person.circle") // установка значка профиля
     
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile,]
        
        self.viewControllers = items.map({ tabBarItem in
            switch tabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())
        
             
            }
        })
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
}


