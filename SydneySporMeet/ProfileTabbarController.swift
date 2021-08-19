//
//  ProfileTabbarController.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 3/25/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import UIKit
class ProfileTabbarController: UITabBarController {
    
    @IBOutlet weak var btnMatch: UIButton!
    var tabbarItem =  UITabBarItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbarItem = self.tabBar.items![0]
        tabbarItem.image = UIImage(named: "icoback")
        tabbarItem = self.tabBar.items![1]

        self.selectedIndex = 0

    }
}
