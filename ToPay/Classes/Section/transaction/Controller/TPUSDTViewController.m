//
//  TPUSDTViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPUSDTViewController.h"
#import "TPUSDTCell.h"
@interface TPUSDTViewController ()

@end

@implementation TPUSDTViewController

static NSString  *TPUSDTCellId = @"USDTCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@0);
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(self.view.mas_height);
     }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPUSDTCell *cell = [tableView dequeueReusableCellWithIdentifier:TPUSDTCellId];
    if (!cell)
        cell = [[TPUSDTCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPUSDTCellId];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
