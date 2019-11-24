//
//  WorkFlowStatusManager.swift
//  CarLarkiOS
//
//  Created by apple on 2019/11/15.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit

protocol WorkFlowStatusManagerDelegate:class {
    func changeStatus(headKey:String,statusText:String,statusColor:UIColor)
    func reloadList()
}

class WorkFlowStatusManager: NSObject {
    public weak var delegate:WorkFlowStatusManagerDelegate?
    // 刷新完成状态
    public func refreshCompleteStatus(details:[String:[YUCellEntity]]?) {
        guard let details = details else {
            return
        }
        for (headKey,secondPageEntities) in details {
            // 是否完善
            var isCompleteAllRequire = true
            // 至少有一个已填写
            var isInputAtLeastOne = false
            // 全选填（无必填）
            var isNoRequired = true
            for entity in secondPageEntities {
                if let serverFieldItem = entity as? ServerFormItem {
                    if serverFieldItem.isRequired == true {
                        isNoRequired = false
                    }
                    if serverFieldItem.serverValue != nil {
                        // 服务器值不为空
                        isInputAtLeastOne = true
                    }else {
                        // 服务器值为空
                        if serverFieldItem.isRequired == true {
                            isCompleteAllRequire = false
                        }
                    }
                }
            }
            var statusText = ""
            var statusColor = UIColor.red
            // 全为可选
            if isNoRequired == true {
                statusColor = UIColor.qmui_color(withHexString:"#BFBFBF")!
                statusText = "可选项"
                    
            }else {
                // 到这里，说明含有必填项
                // 至少有一项填写
                if isInputAtLeastOne == true {
                    if isCompleteAllRequire == true {
                        statusText = "已完善"
                        statusColor = UIColor.qmui_color(withHexString:"#BFBFBF")!
                    }else {
                        statusText = "继续完善"
                    }
                }else {
                    // 一项都没输入
                    statusText = "未完善"
                }
            }
            self.delegate?.changeStatus(headKey: headKey, statusText: statusText,statusColor: statusColor)
        }
        self.delegate?.reloadList()
    }
}
