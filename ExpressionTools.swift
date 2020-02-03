//
//  ExpressionTools.swift
//  Formula
//
//  Created by apple on 2019/12/17.
//  Copyright © 2019 yxy. All rights reserved.
//

import Cocoa
import JavaScriptCore
class ExpressionTools: NSObject {
    class func excuteJavaScript(_ script:String)->String? {
        let context = JSContext()
   
        let result = context?.evaluateScript(script)?.toString()
        return result
    }
}
