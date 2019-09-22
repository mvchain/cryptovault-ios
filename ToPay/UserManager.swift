//
//  UserManager.swift
//  CarLarkiOS
//
//  Created by yxyyxy on 2019/9/11.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit

let UserServerModelKey = "UserServerModelKey"
@objcMembers class UserManager: NSObject {
    /// 单例
    public static let share = UserManager()
    /// 持久化存储,没有密码
    public var userServerModel:UserServerModel? {
        get {
            if let dictionary =  UserDefaults.standard.value(forKey: UserServerModelKey) as? [String:Any] {
                return UserServerModel(fromDictionary: dictionary)
            }else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue?.toDictionary(), forKey:UserServerModelKey )
        }
    }
}
//
//  UserManager.swift
//  CarLarkiOS
//
//  Created by yxyyxy on 2019/9/11.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit

let UserServerModelKey = "UserServerModelKey"
@objcMembers class UserManager: NSObject {
    /// 单例
    public static let share = UserManager()
    /// 持久化存储,没有密码
    public var userServerModel:UserServerModel? {
        get {
            if let dictionary =  UserDefaults.standard.value(forKey: UserServerModelKey) as? [String:Any] {
                return UserServerModel(fromDictionary: dictionary)
            }else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue?.toDictionary(), forKey:UserServerModelKey )
        }
    }
}
//
//  UserManager.swift
//  CarLarkiOS
//
//  Created by yxyyxy on 2019/9/11.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit

let UserServerModelKey = "UserServerModelKey"
@objcMembers class UserManager: NSObject {
    /// 单例
    public static let share = UserManager()
    /// 持久化存储,没有密码
    public var userServerModel:UserServerModel? {
        get {
            if let dictionary =  UserDefaults.standard.value(forKey: UserServerModelKey) as? [String:Any] {
                return UserServerModel(fromDictionary: dictionary)
            }else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue?.toDictionary(), forKey:UserServerModelKey )
        }
    }
}
//
//  UserManager.swift
//  CarLarkiOS
//
//  Created by yxyyxy on 2019/9/11.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit

let UserServerModelKey = "UserServerModelKey"
@objcMembers class UserManager: NSObject {
    /// 单例
    public static let share = UserManager()
    /// 持久化存储,没有密码
    public var userServerModel:UserServerModel? {
        get {
            if let dictionary =  UserDefaults.standard.value(forKey: UserServerModelKey) as? [String:Any] {
                return UserServerModel(fromDictionary: dictionary)
            }else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue?.toDictionary(), forKey:UserServerModelKey )
        }
    }
}
