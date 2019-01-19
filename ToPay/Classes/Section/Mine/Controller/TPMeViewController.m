//
//  TPMeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPMeViewController.h"
#import "TPLanguageViewController.h"
#import "TPAboutViewController.h"
#import "TPTransDetailViewController.h"
#import "TPLoginViewController.h"
#import "TPMeCell.h"
#import "TPMeHeaderView.h"
#import "TPCurrencyList.h"
#import "TPAccountSafeViewController.h"
#import "TPInvitedRegisterViewController.h"
@interface TPMeViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSourceImg;
@end
@implementation TPMeViewController
static NSString  *TPMeCellCellId = @"meCell";
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customNavBar.title = @"我的";
    self.customNavBar.hidden = YES;
    [self showSystemNavgation:NO];
    _dataSource = @[@"账户安全",@"邀请注册",@"语言",@"关于"];
    _dataSourceImg = @[@"language_icon",@"about_icon",@"about_icon",@"about_icon"];
    TPMeHeaderView *headerView = [[TPMeHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@(156+12+STATUS_BAR_HEIGHT));
    }];
    /*
     
     */
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(@0);
        make.top.equalTo(headerView.mas_bottom).with.offset(0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view);
    }];
    [self.view sendSubviewToBack:self.baseTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPMeCell *cell = [tableView dequeueReusableCellWithIdentifier:TPMeCellCellId];
    if (!cell)
        cell = [[TPMeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPMeCellCellId];
    cell.descLab.text = _dataSource[indexPath.row];
    cell.iconImgV.image = [UIImage imageNamed:_dataSourceImg[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        TPAccountSafeViewController *account =[[TPAccountSafeViewController alloc]init];
        [self.navigationController pushViewController:account animated:YES];
        
    }
    if (indexPath.row == 1){
        TPInvitedRegisterViewController *cv = [[TPInvitedRegisterViewController alloc] init];
        [self.navigationController pushViewController:cv animated:YES];
        
    }
    if (indexPath.row == 2)
    {
        TPLanguageViewController *languageVC = [[TPLanguageViewController alloc] init];
        [self.navigationController pushViewController:languageVC animated:YES];
    }
        else if (indexPath.row == 3)
    {
        TPAboutViewController *aboutVC = [[TPAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [QuickDo prettyTableViewCellSeparate:@[@3] cell:cell indexPath:indexPath];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
@end
