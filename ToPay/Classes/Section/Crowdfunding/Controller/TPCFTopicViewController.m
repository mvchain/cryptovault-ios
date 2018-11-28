//
//  TPCFTopicViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCFTopicViewController.h"
#import "TPBuyTokenViewController.h"
#import "TPCrowdConfig.h"
#import "TPCrowdfundCell.h"
@interface TPCFTopicViewController ()

@end

@implementation TPCFTopicViewController

static NSString  *TPReservationCellCellId = @"ReservationCell";

-(TPCrowdfundStyle)type
{
    return 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.backgroundColor = TPF6Color;
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.backgroundColor = TPF6Color;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(0);
         make.left.mas_equalTo(0);
         make.width.equalTo(@(KWidth));
         make.height.mas_equalTo(KHeight);
     }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPCrowdfundCell *cell = [tableView dequeueReusableCellWithIdentifier:TPReservationCellCellId];
    if (!cell)
        cell = [[TPCrowdfundCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPReservationCellCellId WithStyle:self.type];
    
    cell.comView.participateBlock = ^{
        TPBuyTokenViewController *buyTokenVC = [[TPBuyTokenViewController alloc] init];
        [self.navigationController pushViewController:buyTokenVC animated:YES];
    };
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == TPCrowdfundStyleRecord)
    {
        return  192;
    }
        else
    {
        return  220;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TPBuyTokenViewController *buyTokenVC = [[TPBuyTokenViewController alloc] init];
//    [self.navigationController pushViewController:buyTokenVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
