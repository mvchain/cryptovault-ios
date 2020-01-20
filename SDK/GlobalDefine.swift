//
//  GlobalDefine.swift
//  BaseProject
//
//  Created by mc on 2017/8/14.
//  Copyright © 2017年 falconeyes. All rights reserved.
//

import UIKit
import HandyJSON

public let k_Window = UIApplication.shared.keyWindow!

public let k_tabbarBottom: CGFloat = (k_isIphoneX ? 34 : 0)
public let k_tabbarHeight:CGFloat = 49 + k_tabbarBottom
public let k_navibarTop: CGFloat = (k_isIphoneX ? 24 : 0)
public let k_navibarHeight: CGFloat = 44 + k_navibarTop + 20
public let k_AllWidowWidth = (kWINDOW_HEIGHT == 812) ? kWINDOW_WIDTH : (k_isIphone6Plus ? 414 : kWINDOW_WIDTH)
//是否是pad
public let k_isPad = UIDevice.current.model == "iPad"
//struct GlobalDefine {
/************ constant ************/

public let kAPPLICATION = UIApplication.shared
public let kSYS_VERSION: String = UIDevice.current.systemVersion
// 设备操作系统版本号
public let kDeviceSysVersion: Float = (kSYS_VERSION as NSString).floatValue
public let k_NO_LESS_THAN_IOS:(_ x:Float) -> Bool = {(x)->Bool in
    kDeviceSysVersion >= x
}


//屏幕宽高
public let kWINDOW_WIDTH = UIScreen.main.bounds.size.width
public let kWINDOW_HEIGHT = UIScreen.main.bounds.size.height

//屏幕宽高比
public let kWINDOW_WIDTH_SCALE = UIScreen.main.bounds.size.width / 375
public let kWINDOW_HEIGHT_SCALE = UIScreen.main.bounds.size.height / 667

//根据屏幕宽高比 适配宽高  pad上宽度按照 iPhone 最大宽度来
public func KAll_SCALE_WIDTH(width: CGFloat) -> CGFloat {
    let maxWidth = k_isPad ? 414 : kWINDOW_WIDTH
    return maxWidth / 375 * width
}

//按当前屏幕宽高比适配后的宽度和高度
public func kSCALE_WIDTH(width:CGFloat) -> CGFloat {
    return UIScreen.main.bounds.size.width / 375 * width
}
public func kSCALE_HEIGHT(height:CGFloat) -> CGFloat {
    return UIScreen.main.bounds.size.height / 667 * height
}

public func kSCALE_ASPECT_HEIGHT(scale:CGFloat,margin: CGFloat) -> CGFloat {
    return scale * (kWINDOW_WIDTH - margin)
}

//屏幕判断
public let k_isIphone4s: Bool = (kWINDOW_HEIGHT < 568)
public let k_isIphone5: Bool = (kWINDOW_HEIGHT == 568)
public let k_isIphone6: Bool = (kWINDOW_HEIGHT >= 666 && kWINDOW_HEIGHT < 700)
public let k_isIphone6Plus: Bool = (kWINDOW_HEIGHT >= 735)
public let k_isIphone6Bigger: Bool = (kWINDOW_HEIGHT >= 666) //6 或 6plus
////判断机型是否是iPhone X
//public let k_isIphoneX: Bool = (kWINDOW_HEIGHT == 812)
//判断机型是否是iPhone X 系列 x xsR 812x375 , xsMax  xsR 896x414
public let k_isIphoneX: Bool = (kWINDOW_HEIGHT == 812 || kWINDOW_HEIGHT == 896)

//RGB进制颜色值
public func RGBCOLOR(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

//RGBA进制颜色值
public func RGBACOLOR_ALPHA(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//随机颜色
public func RANDOMCOLOR() -> UIColor {
    return UIColor(red: CGFloat(Float(arc4random_uniform(256))/255.0), green: CGFloat(Float(arc4random_uniform(256))/255.0), blue: CGFloat(Float(arc4random_uniform(256))/255.0), alpha: 1)
}

//语言切换
public let NetworkError = LanguageHelper.getKeyWith("网络异常")

//MARK: - 获取IP
public func GetIPAddresses() -> String {
    var addresses = [String]()
    
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while (ptr != nil) {
            let flags = Int32(ptr!.pointee.ifa_flags)
            var addr = ptr!.pointee.ifa_addr.pointee
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        if let address = String(validatingUTF8:hostname) {
                            addresses.append(address)
                        }
                    }
                }
            }
            ptr = ptr!.pointee.ifa_next
        }
        freeifaddrs(ifaddr)
    }
    return addresses.first ?? ""
}

//MARK: - 获取设备ID
public func GetDeviceID() -> String {
    let deviceId = UIDevice.current.identifierForVendor?.uuidString
    return deviceId ?? ""
}

//MARK: - 获取App版本
public func GetAppVersion() -> String {
    let infoDic = Bundle.main.infoDictionary
    let appVersion = infoDic?["CFBundleShortVersionString"] as! String
    return appVersion
}

//MARK: - 获取设备型号
public func GetDeviceModel() -> String {
    
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
        return String(cString: ptr)
    }
    
    if platform == "iPhone1,1" { return "iPhone 2G"}
    if platform == "iPhone1,2" { return "iPhone 3G"}
    if platform == "iPhone2,1" { return "iPhone 3GS"}
    if platform == "iPhone3,1" { return "iPhone 4"}
    if platform == "iPhone3,2" { return "iPhone 4"}
    if platform == "iPhone3,3" { return "iPhone 4"}
    if platform == "iPhone4,1" { return "iPhone 4S"}
    if platform == "iPhone5,1" { return "iPhone 5"}
    if platform == "iPhone5,2" { return "iPhone 5"}
    if platform == "iPhone5,3" { return "iPhone 5C"}
    if platform == "iPhone5,4" { return "iPhone 5C"}
    if platform == "iPhone6,1" { return "iPhone 5S"}
    if platform == "iPhone6,2" { return "iPhone 5S"}
    if platform == "iPhone7,1" { return "iPhone 6 Plus"}
    if platform == "iPhone7,2" { return "iPhone 6"}
    if platform == "iPhone8,1" { return "iPhone 6S"}
    if platform == "iPhone8,2" { return "iPhone 6S Plus"}
    if platform == "iPhone8,4" { return "iPhone SE"}
    if platform == "iPhone9,1" { return "iPhone 7"}
    if platform == "iPhone9,2" { return "iPhone 7 Plus"}
    if platform == "iPhone10,1" { return "iPhone 8"}
    if platform == "iPhone10,2" { return "iPhone 8 Plus"}
    if platform == "iPhone10,3" { return "iPhone X"}
    if platform == "iPhone10,4" { return "iPhone 8"}
    if platform == "iPhone10,5" { return "iPhone 8 Plus"}
    if platform == "iPhone10,6" { return "iPhone X"}
    if platform == "iPhone11,2" { return "iPhone XS"}
    if platform == "iPhone11,4" { return "iPhone XS Max"}
    if platform == "iPhone11,6" { return "iPhone XS Max"}
    if platform == "iPhone11,8" { return "iPhone XR"}
    
    if platform == "iPod1,1" { return "iPod Touch 1G"}
    if platform == "iPod2,1" { return "iPod Touch 2G"}
    if platform == "iPod3,1" { return "iPod Touch 3G"}
    if platform == "iPod4,1" { return "iPod Touch 4G"}
    if platform == "iPod5,1" { return "iPod Touch 5G"}
    
    if platform == "iPad1,1" { return "iPad 1"}
    if platform == "iPad2,1" { return "iPad 2"}
    if platform == "iPad2,2" { return "iPad 2"}
    if platform == "iPad2,3" { return "iPad 2"}
    if platform == "iPad2,4" { return "iPad 2"}
    if platform == "iPad2,5" { return "iPad Mini 1"}
    if platform == "iPad2,6" { return "iPad Mini 1"}
    if platform == "iPad2,7" { return "iPad Mini 1"}
    if platform == "iPad3,1" { return "iPad 3"}
    if platform == "iPad3,2" { return "iPad 3"}
    if platform == "iPad3,3" { return "iPad 3"}
    if platform == "iPad3,4" { return "iPad 4"}
    if platform == "iPad3,5" { return "iPad 4"}
    if platform == "iPad3,6" { return "iPad 4"}
    if platform == "iPad4,1" { return "iPad Air"}
    if platform == "iPad4,2" { return "iPad Air"}
    if platform == "iPad4,3" { return "iPad Air"}
    if platform == "iPad4,4" { return "iPad Mini 2"}
    if platform == "iPad4,5" { return "iPad Mini 2"}
    if platform == "iPad4,6" { return "iPad Mini 2"}
    if platform == "iPad4,7" { return "iPad Mini 3"}
    if platform == "iPad4,8" { return "iPad Mini 3"}
    if platform == "iPad4,9" { return "iPad Mini 3"}
    if platform == "iPad5,1" { return "iPad Mini 4"}
    if platform == "iPad5,2" { return "iPad Mini 4"}
    if platform == "iPad5,3" { return "iPad Air 2"}
    if platform == "iPad5,4" { return "iPad Air 2"}
    if platform == "iPad6,3" { return "iPad Pro 9.7"}
    if platform == "iPad6,4" { return "iPad Pro 9.7"}
    if platform == "iPad6,7" { return "iPad Pro 12.9"}
    if platform == "iPad6,8" { return "iPad Pro 12.9"}
    
    if platform == "i386"   { return "iPhone Simulator"}
    if platform == "x86_64" { return "iPhone Simulator"}
    
    return platform
}

//MARK: - 上传登录日志信息
public func uploadLoginInfo(uid: Int) {
    let dic = ["uid":uid,
               "ip":GetIPAddresses(),
               "deviceType":5,
               "deviceId":GetDeviceID(),
               "deviceModel":GetDeviceModel(),
               "appVersion":GetAppVersion(),
               "createTimeString":TimeUtils.getCurrentTimeYMDHMS()] as [String : Any]
    
    LYNNetWorkManager.shared.post(url: "/user/login/log", parameters: dic, useHandyJson: false, contentType: nil) { (error, result) -> (Void) in
        if result != nil {
            if let response = result as? [String: Any] {
                let model = JSONDeserializer<LYNBaseModel>.deserializeFrom(dict: response)!
                if model.success {
                    print("上传成功")
                }
            }
        }
    }
}

//MARK: - 上传地理位置信息
public func uploadLocationInfo(uid: Int, latitude:String, longtitude:String) {
    let dic = ["uid":uid,
               "latitude":latitude,
               "longitude":longtitude,
               "deviceId":GetDeviceID(),
               "createTimeString":TimeUtils.getCurrentTimeYMDHMS()] as [String : Any]
    
    LYNNetWorkManager.shared.post(url: "/user/location", parameters: dic, useHandyJson: false, contentType: nil) { (error, result) -> (Void) in
        if result != nil {
            if let response = result as? [String: Any] {
                let model = JSONDeserializer<LYNBaseModel>.deserializeFrom(dict: response)!
                if model.success {
                    print("上传成功")
                }
            }
        }
    }
}

