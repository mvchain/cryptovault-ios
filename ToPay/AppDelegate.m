//
//  AppDelegate.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "AppDelegate.h"

#import "TPCapitalViewController.h"
#import "TPTransactionViewController.h"
#import "TPCrowdfundingViewController.h"

#import "TPMeViewController.h"
#import <WRNavigationBar/WRNavigationBar.h>



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setUpViewController];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    [self setNavBarAppearence];
    [self setUpIQKeyBoardManager];
    return YES;
}

-(void)setUpViewController
{
    TPCapitalViewController *capitalVC = [[TPCapitalViewController alloc] init];
    UIViewController *capitalNav = [[UINavigationController alloc] initWithRootViewController:capitalVC];
    
    
    TPTransactionViewController *transationVC = [[TPTransactionViewController alloc] init];
    UIViewController *transationNav = [[UINavigationController alloc] initWithRootViewController:transationVC];
    
    
    TPCrowdfundingViewController *crowdfundingVC = [[TPCrowdfundingViewController alloc] init];
    UIViewController *crowdfundingNav = [[UINavigationController alloc] initWithRootViewController:crowdfundingVC];
    
    TPMeViewController *meVC = [[TPMeViewController alloc] init];
    UIViewController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    tabBarController.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];

    
//    tabBarController.tabBar.backgroundView.layer.cornerRadius = 10;
    tabBarController.tabBar.backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    tabBarController.tabBar.backgroundView.layer.shadowOffset = CGSizeMake(2, 5);
    tabBarController.tabBar.backgroundView.layer.shadowOpacity = 0.5;
    tabBarController.tabBar.backgroundView.layer.shadowRadius = 5;
    
    [tabBarController.tabBar setHeight:49];
    [tabBarController setViewControllers:@[capitalNav,transationNav,crowdfundingNav,meNav]];
    
    self.viewController = tabBarController;
    
    [self  customizeTabBarForCOntroller:tabBarController];
}

-(void)customizeTabBarForCOntroller:(RDVTabBarController *)tabBarController
{
    NSArray *tabBarItemImages = @[@"main", @"together", @"trand", @"wallet"];
    NSArray *tabBarItemTitle = @[@"资产", @"交易", @"众筹", @"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items])
    {
        

        item.title = [tabBarItemTitle objectAtIndex:index];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon_sel",[tabBarItemImages objectAtIndex:index]]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon_normal",[tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedimage];
        
        NSDictionary *tabBarTitleUnselectedDic = @{NSForegroundColorAttributeName:TP59Color,NSFontAttributeName:[UIFont systemFontOfSize:10]};
        
        NSDictionary *tabBarTitleSelectedDic = @{NSForegroundColorAttributeName:TPMainColor,NSFontAttributeName:[UIFont systemFontOfSize:10]};
        
        item.unselectedTitleAttributes = tabBarTitleUnselectedDic;
        item.selectedTitleAttributes = tabBarTitleSelectedDic;
        
        if (iPhoneX)
        {
            item.imagePositionAdjustment = UIOffsetMake(0, -10);
            item.titlePositionAdjustment = UIOffsetMake(0, -5);
        }
            else
        {
            item.titlePositionAdjustment = UIOffsetMake(0, 3);
        }
        index ++;
    }
}

-(void)customizeInterface
{
//     UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
}

-(void)setNavBarAppearence
{
    [WRNavigationBar wr_widely];
    
//    [WRNavigationBar wr_setBlacklist:@[@"TPTransactionViewController"]];
    
    // 导航栏默认背景颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor redColor]];
    
    // 导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor clearColor]];
    
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor greenColor]];
    
    //统一设置状态
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    
    //导航栏底部分割线隐藏
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

-(void)setUpIQKeyBoardManager
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    
    keyboardManager.enable = YES;
    
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
