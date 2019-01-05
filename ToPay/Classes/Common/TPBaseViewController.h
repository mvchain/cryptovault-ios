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

@property (nonatomic, strong) UIImageView *noDataView;
@property (nonatomic, assign) BOOL isNomoreData;
@property (strong,nonatomic ) NSMutableArray  * noMoreDataArray;

/*
 * 显示空数据界面
 */
-(void)showNoDataView:(BOOL)isShow;


-(void)showSystemNavgation:(BOOL)isShow;

// 添加
-(void)setupRefreshWithShowFooter:(BOOL)isShowFooter;

/*
 * 加载新数据
 */
-(void)loadNewTopics;


/*
 * 加载更多数据
 */
-(void)loadMoreTopics;


@end
