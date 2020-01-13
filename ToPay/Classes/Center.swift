//
//  LYNBaseShowViewController.swift
//  CarLoanHelper
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 apple.com. All rights reserved.
//

import UIKit

class LYNBaseShowViewController: LYNBaseViewController {
    var dataArray = [LYNCustomerModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setLeftBarItem(title: nil, image: UIImage(named: "back"))
        if controllerModel.name.contains("附件信息-"){
            let array = controllerModel.name.split(separator: "-")
            let addtionStr = String(array[1]).prefix(2)
            setTitleView(title: "附件信息("+addtionStr+")", isShow: true)
        }else {
            setTitleView(title: controllerModel.name, isShow: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func didClickNaviLeftBarItem() {
        for vc in (navigationController?.childViewControllers)! {
            if vc.isKind(of: LYNOrderDetailViewController().classForCoder){ //我的订单模块 详情
                navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 子控件
    internal override func initSubviews() {
        view.addSubview(tableView)
        tableView.register(LYNTBaseShowTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
   
    internal override func setSubviewsConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(1)
            make.top.bottom.equalTo(view)
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.bounces = false
        table.separatorStyle = .none
        table.allowsSelection = false
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        return table
    }()
}
