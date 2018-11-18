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
#import "TPMeCell.h"
#import "TPMeHeaderView.h"
@interface TPMeViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TPMeViewController

static NSString  *TPMeCellCellId = @"meCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self. navigationItem.title = @"我的";
    _dataSource = @[@"语言",@"关于"];
    TPMeHeaderView *headerView = [[TPMeHeaderView alloc] init];
    headerView.height = 176;
    self.baseTableView.tableHeaderView = headerView;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
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
        else
    {
        TPAboutViewController *aboutVC = [[TPAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
