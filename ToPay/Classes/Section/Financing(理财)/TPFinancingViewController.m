//
//  TPFinancingViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPFinancingViewController.h"

@interface TPFinancingViewController ()

@end

@implementation TPFinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpNav {
    self.customNavBar.title = @"理财";
    [self.customNavBar.rightButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
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
