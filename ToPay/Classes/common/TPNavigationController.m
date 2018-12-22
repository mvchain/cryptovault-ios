//
//  TPNavigationController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/17.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPNavigationController.h"

@interface TPNavigationController ()

@end

@implementation TPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0 )
    {
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //所有设置搞定后，在push控制器
    [super pushViewController:viewController animated:animated];
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
