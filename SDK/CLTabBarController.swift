//
//  CLTabBarController.swift
//  CarLark
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Falconeyes. All rights reserved.
//

import UIKit

class CLTabBarController: UITabBarController {
//private var navigator: NavigatorType?
//    let navigator = Navigator()
    
//    private let navigator: NavigatorType
//    
//    init(navigator: NavigatorType) {
//        self.navigator = navigator
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 解决pop回来tabbarItem图标文字偏移动画问题
        self.tabBar.isTranslucent = false
        
        self.setupChildController(childVC: CLHomeViewController(navigator: navigator), normalImage: UIImage(named: "nav_gzt_n")!, selectedImage: UIImage(named: "nav_gzt_s")!, title: "首页")

        self.setupChildController(childVC: CLToolViewController(navigator: navigator), normalImage: UIImage(named: "nav_gj_n")!, selectedImage: UIImage(named: "nav_gj_s")!, title: "工具")

        self.setupChildController(childVC: CLMessageViewController(navigator: navigator), normalImage: UIImage(named: "nav_xx_n")!, selectedImage: UIImage(named: "nav_xx_s")!, title: "消息")

        self.setupChildController(childVC: CLMineViewController(navigator: navigator), normalImage: UIImage(named: "nav_wd_n")!, selectedImage: UIImage(named: "nav_wd_s")!, title: "我的")
        
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:iThemeColor], for: .selected)
        
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:iLightGrayTitleColor], for: .normal)
        
    }
    
    // MARK: - private function
    private func setupChildController(childVC: UIViewController?, normalImage: UIImage?, selectedImage: UIImage?, title: String) {
        let nav = UINavigationController(rootViewController: childVC!)
        childVC?.title = title
//        childVC?.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: iThemeColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)], for: .selected)
//        childVC?.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: iLightGrayTitleColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        childVC?.tabBarItem.image = normalImage?.withRenderingMode(.alwaysOriginal)
        childVC?.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        childVC?.tabBarItem.title = title
//        childVC?.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        childVC?.tabBarController?.tabBar.showBadgOn(index: 1, tabbarItemNums: 1)
        self.addChild(nav)
    }
    
}

extension CLTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[3] && !isLogin() {
//            pushVC(IMLoginViewController(), animated: true)
            tabBarController.tabBar.showBadgOn(index: 1, tabbarItemNums: 1)
            return false
        }
        
        return true
    }
}
