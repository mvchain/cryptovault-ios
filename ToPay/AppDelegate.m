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
#import "TPGuiderViewController.h"
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
    [self setUpJpush];

    
    [JPUSHService setupWithOption:launchOptions appKey:@"ffb83d2be1729d733dd03c34"
                          channel:nil
                 apsForProduction:YES
            advertisingIdentifier:nil];
    return YES;
}

- (void)setUpJpush {
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
}

-(void)setUpWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([TPLoginUtil isLogin] == NO){
        UINavigationController *nav = [[UINavigationController alloc] init];
        nav.navigationBar.hidden = YES;
        [nav setNavigationBarHidden:YES];
        
        TPGuiderViewController *tp = [[TPGuiderViewController alloc] init];
        nav.viewControllers = @[tp];
        [self.window setRootViewController:nav];
    }
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
// 192.168.15.31
//    47.110.234.233
    [WYNetworkConfig sharedConfig].baseUrl = @"http://192.168.15.31:10086/";
    [WYNetworkConfig sharedConfig].timeoutSeconds = 10;
    if ([TPLoginUtil userInfo].token)
    {
        [[WYNetworkConfig sharedConfig] addCustomHeader:@{
                                                          @"Authorization":[TPLoginUtil userInfo].token,
                                                          @"Accept-Language":@"zh-cn"
                                                    }];
    }
}

- (void)refreshToken
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
                                                            @"Authorization":loginM.token,
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
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark Jpush

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
   
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    NSLog(@"%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}


@end
