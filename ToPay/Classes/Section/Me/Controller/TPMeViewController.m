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
@interface TPMeViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSourceImg;
@end

@implementation TPMeViewController

static NSString  *TPMeCellCellId = @"meCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    YYCache *yyCache = [YYCache cacheWithName:TPCacheName];
//    
//    TPCurrencyList *newList = (TPCurrencyList *)[yyCache objectForKey:TPCurrencyListKey];
//    
//    NSLog(@"newList:%@",newList);
    
    self.customNavBar.title = @"我的";
    [self showSystemNavgation:NO];
    
    _dataSource = @[@"语言",@"关于",@"状态详情",@"登录"];
    _dataSourceImg = @[@"language_icon",@"about_icon",@"about_icon",@"about_icon"];

    TPMeHeaderView *headerView = [[TPMeHeaderView alloc] init];
    headerView.height = 176;
    self.baseTableView.tableHeaderView = headerView;

    self.baseTableView.left = 0;
    self.baseTableView.top = StatusBarAndNavigationBarHeight + 10;
    self.baseTableView.width = KWidth;
    self.baseTableView.height = self.view.height;
    
    
    
    [self.view sendSubviewToBack:self.baseTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPMeCell *cell = [tableView dequeueReusableCellWithIdentifier:TPMeCellCellId];
    if (!cell)
        cell = [[TPMeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPMeCellCellId];
    
    cell.descLab.text = _dataSource[indexPath.row];
    cell.iconImgV.image = [UIImage imageNamed:_dataSourceImg[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  48;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        TPLanguageViewController *languageVC = [[TPLanguageViewController alloc] init];
        [self.navigationController pushViewController:languageVC animated:YES];
    }
        else if (indexPath.row == 1)
    {
        TPAboutViewController *aboutVC = [[TPAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
        else if (indexPath.row == 2)
    {
        TPTransDetailViewController *aboutVC = [[TPTransDetailViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
        else
    {
        
        TPLoginViewController *aboutVC = [[TPLoginViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
