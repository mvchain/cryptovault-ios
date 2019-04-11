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
#import "Aspects.h"
#endif
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>
#define UM_KEY @"5ca41bbc20365710df000d29"
@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (copy) NSMutableArray *arr ;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setLanguage];
    [self setUpUM];
    [self aop_Setting];
    [self setUpNetWorkManager];
    [self setNavBarAppearence];
    [self setUpIQKeyBoardManager];
    [self setUpJpush];
    [self setObserver];
    [self setUpWindow];
    
   NSString *str =  [QuickGet encryptPwd:@"123456" salt:@"TZImagePickerController"];
    NSLog(@"%@",str);
    
    
    [WRNavigationBar wr_setBlacklist:@[@"TZImagePickerController"]];
   // NSString *str = Localized(@"capital");
    [JPUSHService setupWithOption:launchOptions appKey:@"ffb83d2be1729d733dd03c34"
                          channel:nil
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    return YES;
    
}
- (void)setUpUM{
    [UMConfigure initWithAppkey:UM_KEY channel:@"App Store"];
}
- (void)aop_Setting {
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo)
     {
             [TPLoginUtil refreshToken_if_err_logout ];
        
     } error:NULL];
    
    [UILabel aspect_hookSelector:@selector(setText:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo)
     {
         UILabel *label =   aspectInfo.instance;
         NSString *text = label.text;
         if (![text containsString:@"."]) return ;
         int dotIndex = (int)[text rangeOfString:@"."].location;
         if (!(dotIndex-1>=0 && dotIndex+1<text.length) )return ;
         NSMutableString *mText = [[NSMutableString alloc]initWithString:text];
         BOOL firstZero = YES;
         int from=1,to=0;
         for (int i = (int)mText.length-1;i>=0;i--) {
             if ([[mText substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"0"]) {
                 if (firstZero ) {
                     to = (int)i;
                     firstZero = NO;
                 }
             }else {
                 if(!firstZero) {
                     from = (int)i+2;
                     break;
                 }
             }
         }
         if (from>to)return;
         [mText deleteCharactersInRange:NSMakeRange(from, to-from+1)];
         [label setText:mText];
         
         
     } error:NULL];
}
- (void)setObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(net_noti:) name:kNotiNetSucc object:nil];
}
- (void)net_noti:(NSNotification *)noti {
    
}
- (void)setLanguage {
    
   if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];

        if ([language hasPrefix:@"zh-Hans"]) {
            //开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
  }
   
    

    
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

- (int)sum:(int )a b:(int)b {
    __block int sum = 0 ;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sum = a +b;
        NSLog(@"%@",[NSThread currentThread]);
    });
    sleep(2);
    return sum;
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
// 47.110.234.233
// 正式 com.mvc.cryptovault https://www.bzvp.net/api/app/
// 测试 N-NSTechnology.ToPay http://47.110.234.233:10086/
    
    
    NSString *this_cur = [QuickGet getCurrentServerUrl];
    [WYNetworkConfig sharedConfig].baseUrl = this_cur;
    [WYNetworkConfig sharedConfig].timeoutSeconds = 10;
    if ([TPLoginUtil userInfo].token)
    {
        [[WYNetworkConfig sharedConfig] addCustomHeader:@{
                                                          @"Authorization":[TPLoginUtil userInfo].token,
                                                          @"Accept-Language":@"zh-cn"
                                                    }];
    }
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
