//
//  YHMainTabbarVC.swift
//  UnitOneTask
//
//  Created by Helles, Yasmeen on 24/03/2022.
//

import UIKit

class YHMainTabbarVC:UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hideBackWord()
        self.title = "Home"
        self.selectedIndex = 2
        tabBar.unselectedItemTintColor = "412362".color
      
                        }

}
