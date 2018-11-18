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
@interface TPCapitalViewController ()

@end

@implementation TPCapitalViewController

static NSString  *TPCapitalCellCellId = @"CapitalCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"VP Wallet";
  
    [self setNavItem];
    
    
    TPCapitalHeaderView *headerView = [[TPCapitalHeaderView alloc] init];
    headerView.height = 142;
    self.baseTableView.tableHeaderView = headerView;
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
        make.left.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
}

-(void)setNavItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(notiClick) image:[UIImage imageNamed:@"note_icon_1"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(addClick) image:[UIImage imageNamed:@"add_icon_black"]];
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


#pragma mark - 点击事件
-(void)notiClick
{
//    NSLog(@"通知");
    TPNotiViewController *notiVC = [[TPNotiViewController alloc] init];
    [self.navigationController pushViewController:notiVC animated:YES];
    
}

-(void)addClick
{
    NSLog(@"添加");
}
@end
