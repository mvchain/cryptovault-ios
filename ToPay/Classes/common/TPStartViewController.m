//
//  TPStartViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/19.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPStartViewController.h"

@interface TPStartViewController ()

@end

@implementation TPStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPF6Color;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
