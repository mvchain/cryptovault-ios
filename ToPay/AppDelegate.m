//
//  AppDelegate.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "AppDelegate.h"
#import "TPLoginViewController.h"
#import "YUTabBarController.h"
#import <WRNavigationBar/WRNavigationBar.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setUpNetWorkManager];
 
    [self refreshToken];

    [self setUpWindow];
    
    [self setNavBarAppearence];
    
    [self setUpIQKeyBoardManager];
    
    return YES;
}

-(void)setUpWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([TPLoginUtil isLogin] == NO)
        [self.window setRootViewController:[[TPLoginViewController alloc] init]];
    else
        [self.window setRootViewController:[[YUTabBarController alloc] config]];
    
    [self.window makeKeyAndVisible];
}

-(void)setNavBarAppearence
{
    [WRNavigationBar wr_widely];
//    @"NIMScannerViewController",
    [WRNavigationBar wr_setBlacklist:@[@"TPAddTokenViewController",
                                       @"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController"]];
    
    // 导航栏默认背景颜色
//    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor redColor]];
    
    // 导航栏所有按钮的默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor redColor]];
    
    // 设置导航栏标题默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor redColor]];
    
    //统一设置状态
//    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    
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


-(void)setUpNetWorkManager
{
// 192.168.15.21
//    47.110.234.233
    [WYNetworkConfig sharedConfig].baseUrl = @"http://47.110.234.233:10086/";
    [WYNetworkConfig sharedConfig].timeoutSeconds = 10;
    if ([TPLoginUtil userInfo].token)
    {
        [[WYNetworkConfig sharedConfig] addCustomHeader:@{
                                                          @"Authorization":[TPLoginUtil userInfo].token,
                                                          @"Accept-Language":@"zh-cn"
                                                    }];
    }
}

-(void)refreshToken
{
    if ([TPLoginUtil isLogin] == NO)
    {
        [USER_DEFAULT setObject:@"1" forKey:TPNowLegalCurrencyKey];
        [USER_DEFAULT setObject:@"￥" forKey:TPNowLegalSymbolKey]; 
        return ;
    }
    
    [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":[TPLoginUtil userInfo].refreshToken}];
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/refresh" parameters:nil success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
           TPLoginModel *loginM = [TPLoginUtil userInfo];
            loginM.token = responseObject[@"data"];
            [TPLoginUtil saveUserInfo:loginM];
            
            [[WYNetworkConfig sharedConfig] addCustomHeader:@{
                                                              @"Authorization":[TPLoginUtil userInfo].token,
                                                              @"Accept-Language":@"zh-cn"
                                                              }];
            [TPLoginUtil requestExchangeRate];
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"刷新token失败");
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
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

#pragma mark Jpush

/*
 * @brief handle UserNotifications.framework [willPresentNotification:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 前台得到的的通知对象
 * @param completionHandler 该callback中的options 请使用UNNotificationPresentationOptions
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    
}
/*
 * @brief handle UserNotifications.framework [didReceiveNotificationResponse:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param response 通知响应对象
 * @param completionHandler
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void ))completionHandler {
    
}

/*
 * @brief handle UserNotifications.framework [openSettingsForNotification:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 当前管理的通知对象
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification NS_AVAILABLE_IOS(12.0) {
    
}
@end
