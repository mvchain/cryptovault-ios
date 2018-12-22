//
//  TPRecordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPRecordViewController.h"

@interface TPRecordViewController ()

@end

@implementation TPRecordViewController

-(TPCrowdfundStyle)type
{
    return TPCrowdfundStyleRecord;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.title = @"众筹记录";
    [self showSystemNavgation:NO];

    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_1"]];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
    [self.view sendSubviewToBack:self.baseTableView];
    
    [self.baseTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated {

    
    [super viewWillDisappear:animated];
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
