//
//  YURootViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/15.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YURootViewController.h"
#define $ self
@implementation YURootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self noVerticalScrollIndicator_All];
    
    
}

- (void)noVerticalScrollIndicator_All{
    [self TraverseAllSubviews:self.view];
}
//遍历父视图的所有子视图，包括嵌套的子视图
- (void)TraverseAllSubviews:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ( [subView isKindOfClass:UIScrollView.class] ) {
            UIScrollView *sc = (UIScrollView *)subView;
            sc.showsVerticalScrollIndicator = NO;
        }
        if (subView.subviews.count) {
            [self TraverseAllSubviews:subView];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
