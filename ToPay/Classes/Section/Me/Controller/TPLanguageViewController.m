//
//  TPLanguageViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPLanguageViewController.h"
#import "TPLangUageCell.h"
@interface TPLanguageViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TPLanguageViewController

static NSString  *TPLangUageCellCellId = @"languageCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.title = @"语言";
    self.customNavBar.title = @"语言";
    [self.view sendSubviewToBack:self.baseTableView];
    _dataSource = @[@"中文",@"英文",@"韩文",@"日文"];
    [self showSystemNavgation:NO];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.top.equalTo(@(StatusBarAndNavigationBarHeight + 12));
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
    TPLangUageCell *cell = [tableView dequeueReusableCellWithIdentifier:TPLangUageCellCellId];
    if (!cell)
        cell = [[TPLangUageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPLangUageCellCellId];
    
    cell.langLab.text = _dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  48;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
