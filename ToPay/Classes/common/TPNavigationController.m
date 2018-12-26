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

    if (self.childViewControllers.count > 0 ) {
      
        //左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.3];
        [backButton setImage:[UIImage imageNamed:@"back_icon_black"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back_icon_white"] forState:UIControlStateHighlighted];
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        // 这句代码放在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //所有设置搞定后，在push控制器
    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}

/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
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
