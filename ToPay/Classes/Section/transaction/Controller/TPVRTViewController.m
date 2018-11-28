
//
//  TPVRTViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPVRTViewController.h"
#import "TPVRTCell.h"

#import "TPTranDetailViewController.h"
@interface TPVRTViewController ()

@end

@implementation TPVRTViewController

static NSString  *TPVRTCellId = @"VRTCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    TPVRTCell *cell = [tableView dequeueReusableCellWithIdentifier:TPVRTCellId];
    if (!cell)
        cell = [[TPVRTCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPVRTCellId];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPTranDetailViewController *tranDetailVC = [[TPTranDetailViewController alloc] init];
    [self.navigationController pushViewController:tranDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
