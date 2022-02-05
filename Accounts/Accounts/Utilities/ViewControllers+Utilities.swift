//
//  ViewControllers+Utilities.swift
//  Accounts
//
//  Created by Ben Garrison on 2/5/22.
//

import UIKit

extension UIViewController {
    func setupStatusBar() {
//        let statusBarSize = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        let frame: CGFloat = 0
//        let statusBarView = UIView(frame: frame)
//
//        statusBarView.backgroundColor = applicationColor
//        view.addSubview(statusBarView)
    }
    
    func setupTabBarImage(imageName: String, title: String) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
}


//func getStatusBarHeight() -> CGFloat {
//    var statusBarHeight: CGFloat = 0
//    if #available(iOS 13.0, *) {
//        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//    } else {
//        statusBarHeight = UIApplication.shared.statusBarFrame.height
//    }
//    return statusBarHeight
//}
