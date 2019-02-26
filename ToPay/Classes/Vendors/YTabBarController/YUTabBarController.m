//
//  YUTabBarController.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "YUTabBarController.h"
#import "YUTabBarConfig.h"
#import "TPNavigationController.h"

#import "TPCapitalViewController.h"
#import "TPTransactionViewController.h"
#import "TPCrowdfundingViewController.h"
#import "TPMeViewController.h"
#import "TPFinancingViewController.h"



//#import "YCircleController.h"
//#import "YMeController.h"
//#import "YUPublishViewController.h"

//#import "YShortVideoViewController.h"
@interface YUTabBarController ()<YUTabBarDelegate>
{
    YUTabBarConfig *config;
}
@end

@implementation YUTabBarController

- (instancetype)config
{
    TPNavigationController *navC = [[TPNavigationController alloc]initWithRootViewController:[[TPCapitalViewController alloc] init]];
    TPNavigationController *navC_1 = [[TPNavigationController alloc]initWithRootViewController:[[TPFinancingViewController alloc] init]];
    TPNavigationController *navC1 = [[TPNavigationController alloc]initWithRootViewController:[[TPTransactionViewController alloc] init]];
    TPNavigationController *navC2 = [[TPNavigationController alloc]initWithRootViewController:[[TPCrowdfundingViewController alloc] init]];
    TPNavigationController *navC3 = [[TPNavigationController alloc]initWithRootViewController:[[TPMeViewController alloc] init]];
    
    config = [YUTabBarConfig config];
    config.titleFont = 10.0f;
//    config.isClearTabBarTopLine = NO;
    
//    config.tabBarController.YU_TabBar.layer.shadowColor = [UIColor blackColor].CGColor;
//    config.tabBarController.YU_TabBar.layer.shadowOffset = CGSizeMake(2, 5);
//    config.tabBarController.YU_TabBar.layer.shadowOpacity = 0.5;
//    config.tabBarController.YU_TabBar.layer.shadowRadius = 5;
    
    
    config.norTitleColor = TP59Color;
    [config setSelTitleColor:TPMainColor];
    config.imageOffset = 8.0f;
    config.titleOffset = 0.1f;
    config.imageSize = CGSizeMake(23, 23);

    return [self initWithTabBarControllers:@[navC,navC_1,navC1,navC2,navC3] NorImageArr:@[@"assets_unselected_icon",@"financial_unselected",@"trand_unselected_icon",@"Crowdfunding_unselected_icon",@"mine_unselected_icon"] SelImageArr:@[@"assets_selected_icon",@"financial_selected",@"trand_selected_icon",@"Crowdfunding_selected_icon",@"mine_selected_icon"] TitleArr:@[@"资产",@"理财",@"交易",@"众筹",@"我的"] Config:config];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setShadowImage:[self imageWithColor:[UIColor blackColor]  size:CGSizeMake(KWidth, 0.7)]];
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
       
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -3);
       
    self.tabBar.layer.shadowOpacity = 0.25;
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLanguage) name:KNotiLanguageChange object:nil];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // [QuickDo checkShouldUpdateWithParentVC_onlyNotNewest:self];
}
- (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size
{
        if(!color || size.width<=0|| size.height<=0)return nil;
        CGRect rect = CGRectMake(0.0f,0.0f, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
}


- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(YUTabBarConfig *)config{
    self.viewControllers = controllers;
    self.YU_TabBar = [[YUTabBar alloc] initWithFrame:self.tabBar.frame norImageArr:norImageArr SelImageArr:selImageArr TitleArr:titleArr Config:config];
    self.YU_TabBar.myDelegate = self;
    
    [self setValue:self.YU_TabBar forKeyPath:@"tabBar"];
    
    
    [YUTabBarConfig config].tabBarController = self;
    
    //KVO
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    [self updateLanguage];
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSInteger selectedIndex = [change[@"new"] integerValue];
    self.YU_TabBar.selectedIndex = selectedIndex;
}

- (void)tabBar:(YUTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    self.selectedIndex = selectIndex;
}

- (void)dealloc {
//    NSLog(@"被销毁了");
    [self removeObserver:self forKeyPath:@"selectedIndex"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)updateLanguage {
    NSString *lan = [[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"];
    
    NSArray *words = @[ Localized(@"capital"),
                        Localized(@"financing"),
                        Localized(@"transaction"),
                        Localized(@"crowd-funding"),
                        Localized(@"mine")];
    [self.YU_TabBar changeTitles:words];
    
}
@end
