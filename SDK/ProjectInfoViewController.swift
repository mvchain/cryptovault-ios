//
//  ProjectInfoViewController.swift
//  CarLarkiOS
//
//  Created by yxyyxy on 2019/8/27.
//  Copyright © 2019 yxy. All rights reserved.
//

import UIKit

class ProjectInfoViewController: BaseViewController {

    @IBOutlet weak var pageListView: YUPageListView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initSetting()
    }
}

extension ProjectInfoViewController {
    private func initNav() {
        self.yu_showCustomNavBar(withTitle: "项目信息")
    }
    private func initSetting() {
        pageListView.firstPageBlock = { (complete) in
//            let head_baseInfo = FormBaseHeaderCellEntity(withContent: "基本信息")
//            let clientType = FormBaseStringPickerCellEntity(leftString: "客户类型", rightString: "个人")
//            clientType.pickerViewAppearanceItems = ["个人","组织","公司"]
//
//            let businessMan = FormBaseStringPickerCellEntity(leftString: "业务员", rightString: "张三")
//            let belongCompany = FormBaseStringPickerCellEntity(leftString: "所属机构", rightString: "杭州直营")
//            belongCompany.pickerViewAppearanceItems = ["北京","纽约","缅甸","东京"]
//
//            let head_productInfo = FormBaseHeaderCellEntity(withContent: "产品信息")
//            let productName = FormBaseStringPickerCellEntity(leftString: "产品名称", rightString: "产品1")
//            let times = FormBaseStringPickerCellEntity(leftString: "期数", rightString: "12期")
//            let persentYear = FormBaseInputCellEntity(leftString: "年利率", placeholder: "请输入")
//            let applyCash = FormBaseInputCellEntity(leftString: "申请金额", placeholder: "请输入")
//            applyCash.isCanEdit = false
//            let capitalizeCash = FormBaseInputCellEntity(leftString: "融资金额(元)", placeholder: "请输入")
//            let returnCashDate = FormBaseStringPickerCellEntity(leftString: "还款日期 ", rightString: "请选择")
//            let carPrice = FormBaseInputCellEntity(leftString: "车价（元）", placeholder: "请输入")
//            let insurancePrice = FormBaseInputCellEntity(leftString: "保险费用（元）", placeholder: "请输入")
//            let buyTax = FormBaseInputCellEntity(leftString: "购置税（元）", placeholder: "请输入")
//            let firstPay = FormBaseInputCellEntity(leftString: "首付（元）", placeholder: "请输入")
//            let lastPay = FormBaseInputCellEntity(leftString: "尾付（元）", placeholder: "请输入")
//            let guaranteePrice = FormBaseInputCellEntity(leftString: "保证金（元）", placeholder: "请输入")
//            let gps = FormBaseStringPickerCellEntity(leftString: "GPS ", rightString: "请选择")
//            let addtionFee = FormBaseInputCellEntity(leftString: "备注", placeholder: "请输入")
//
//            let items = [head_baseInfo,
//                         clientType,
//                         businessMan,
//                         belongCompany,
//                         head_productInfo,
//                         productName,
//                         times,
//                         persentYear,
//                         applyCash,
//                         capitalizeCash,
//                         returnCashDate,
//                         carPrice,
//                         insurancePrice,
//                         buyTax,
//                         firstPay,
//                         lastPay,
//                         guaranteePrice,
//                         gps,
//                         addtionFee]
            //complete(Getter.formItemsWithSeparator(items: items))
        }
        pageListView.beginRefreshHeaderWithNoAnimate()
        
        /// 事件区域
        
        pageListView.yu_eventProduceByInnerCellView = {[unowned self ] (eventName:String,content:Any,sender:Any)in
            
            
            
        }
    }
}
