//
//  TPBaseViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

@interface TPBaseViewController ()

@end

@implementation TPBaseViewController

-(WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}


-(void)showSystemNavgation:(BOOL)isShow
{
   self.navigationController.navigationBar.hidden = !isShow;
}

-(void)showNoDataView:(BOOL)isShow
{
    self.noDataView.hidden = !isShow;
    self.baseTableView.hidden = isShow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationController.navigationBar.hidden = YES;
    
    [self setupNavBar];
    
}


-(void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = TP59Color;
    self.customNavBar.titleLabelFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];//FONT(17);
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_icon_black"]];
    }
    TPWeakSelf;
    [self.customNavBar setOnClickLeftButton:^
    {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}


-(UIImageView *)noDataView
{
    if (_noDataView == nil) {
        _noDataView = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"kongkongruye"]];
        [self.view addSubview:_noDataView];
        
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).with.offset(-70);
            make.size.equalTo(@180);
        }];
    }
    return _noDataView;
}



-(UITableView *)baseTableView
{
    if (!_baseTableView)
    {
        _baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _baseTableView.backgroundColor = TPF6Color;
        _baseTableView.tableFooterView = [[UIView alloc]init];
        
        [self.view addSubview:_baseTableView];
    }
    return _baseTableView;
}

@end
