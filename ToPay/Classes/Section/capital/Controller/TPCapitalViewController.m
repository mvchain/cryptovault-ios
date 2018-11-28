//
//  TPCapitalViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCapitalViewController.h"
#import "TPTokenKindViewController.h"
#import "TPNotiViewController.h"
#import "TPCapitalCell.h"
#import "TPCapitalHeaderView.h"
#import "TPAddTokenViewController.h"
#import <WRNavigationBar/WRCustomNavigationBar.h>
#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + StatusBarAndNavigationBarHeight*2)
//#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 260

@interface TPCapitalViewController ()


@end

@implementation TPCapitalViewController

static NSString  *TPCapitalCellCellId = @"CapitalCell";




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgation];
    
    
    UIImageView *navBack = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"bg_nav_1"]];
    [self.view addSubview:navBack];
    [navBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@198);
    }];
    [self.view sendSubviewToBack:navBack];
    
    TPCapitalHeaderView *headerView = [[TPCapitalHeaderView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.height = 142;
    self.baseTableView.tableHeaderView = headerView;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.bounces = NO;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
        make.left.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
}

-(void)setNavgation
{
    [self showSystemNavgation:NO];
    self.customNavBar.title = @"个人中心";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.barBackgroundColor = TPMainColor;
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"note_icon_1"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"add_icon_white"]];
    
    TPWeakSelf;
    [self.customNavBar setOnClickLeftButton:^
    {
        TPNotiViewController *notiVC = [[TPNotiViewController alloc] init];
        [weakSelf.navigationController pushViewController:notiVC animated:YES];
    }];
    
    [self.customNavBar setOnClickRightButton:^{
        TPAddTokenViewController *tokenVC = [[TPAddTokenViewController alloc] init];
        [weakSelf.navigationController pushViewController:tokenVC animated:YES];
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPCapitalCell *cell = [tableView dequeueReusableCellWithIdentifier:TPCapitalCellCellId];
    if (!cell)
        cell = [[TPCapitalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPCapitalCellCellId];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TPTokenKindViewController *kindVC = [[TPTokenKindViewController alloc] init];
    [self.navigationController pushViewController:kindVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha =  offsetY /100;

        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
    else
    {
        [self.customNavBar wr_setBackgroundAlpha:0];
    }
}

@end
