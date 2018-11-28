//
//  TPBaseViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WRNavigationBar/WRCustomNavigationBar.h>
@interface TPBaseViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

/** base_tableView */
@property (nonatomic, strong) UITableView  *baseTableView;

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;


-(void)showSystemNavgation:(BOOL)isShow;
@end
