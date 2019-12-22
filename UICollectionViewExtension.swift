//
//  UICollectionViewExtension.swift
//  MiniProject
//
//  Created by yxyyxy on 2019/6/29.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit
extension UICollectionView {
    
    //
    /// 通过Cell类对象判断相应同名nib是否存在
    ///
    /// - Parameter cellClass: Cell的类对象
    /// - Returns: 返回Bool
    func isNibExist (cellClass:AnyClass)->Bool {
        // project.className ,只保留className
        let className:String = NSStringFromClass(cellClass).components(separatedBy: ".").last!
        let mainBundlePath:String = Bundle.main.resourcePath!
        let path:String = "\(mainBundlePath)/\(className).nib"
        let isExist:Bool = FileManager.default.fileExists(atPath:path)
        return isExist
        //
    }
    
    /// 通过Cell的类对象将其注册
    ///
    /// - Parameter cellClass: Cell的类对象
    func registerCell (cellClass:AnyClass) {
        let cellIDString:String = NSStringFromClass(cellClass)
        let cellClassName:String = cellIDString.components(separatedBy: ".").last!
        if isNibExist(cellClass: cellClass) {
            let nib:UINib = UINib.init(nibName: cellClassName, bundle: Bundle.main)
            self.register(nib, forCellWithReuseIdentifier: cellIDString)
        }else {
            self.register(cellClass, forCellWithReuseIdentifier: cellIDString)
        }
    }
}
