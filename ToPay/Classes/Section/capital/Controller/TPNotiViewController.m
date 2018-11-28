//
//  TPNotiViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPNotiViewController.h"
#import "TPNotiCell.h"
@interface TPNotiViewController ()

@end

@implementation TPNotiViewController

static NSString  *TPNotiCellCellId = @"notiCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.title = @"通知";
    self.baseTableView.backgroundColor = TPF6Color;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:TPNotiCellCellId];
    if (!cell)
        cell = [[TPNotiCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPNotiCellCellId];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  76;
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
