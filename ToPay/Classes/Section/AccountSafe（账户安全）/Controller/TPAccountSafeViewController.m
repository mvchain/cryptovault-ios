//
//  TPAccountSafeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPAccountSafeViewController.h"

@interface TPAccountSafeViewController ()

@end

@implementation TPAccountSafeViewController
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    
}

#pragma mark local method
- (void)setUpNav {
    self.customNavBar.title = @"账户安全";
    
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
