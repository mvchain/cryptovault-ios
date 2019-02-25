//
//  JudegeCenter.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/3.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "JudegeCenter.h"

@implementation JudegeCenter
+(BOOL)isETH:(NSString *)ethString
{
    NSString *MOBILE = @"^(0x)?[0-9a-fA-F]{40}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:ethString];
}

+(BOOL)isBTC:(NSString *)btcString
{
    NSString *MOBILE = @"^[123mn][a-zA-Z1-9]{24,34}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:btcString];
}

+ (BOOL)isVaildAddrWithTokenId:(NSString *)tokenId addr:(NSString *)addr {
    
    if ([tokenId isEqualToString:@"4"] || [tokenId isEqualToString:@"2"] )
    {
        return  [self isBTC:addr] ;
    }
        return  [self isETH:addr] ;
}

+ (BOOL) isIphoneX {
    BOOL _iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return _iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            _iPhoneX = YES;
        }
    }
    return _iPhoneX;
}
+ (BOOL)isAvailableEmail:(NSString *)email {
    
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
  return [emailTest evaluateWithObject:email];
  
}
+ (void)isNewstVersion:(void(^)(BOOL isnew_now,BOOL isNetOk,NSString *link))padding {
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"app"
                                          parameters:@{@"appType":@"ipa"}
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 int serv_app_v_code= [res[@"data"][@"appVersionCode"] intValue ] ;
                                                 int local_v_code = [[QuickGet getCurBuildVersion] intValue] ;
                                                 if(serv_app_v_code <= local_v_code) {
                                                     // 本地版本>= 服务器版本
                                                     padding(YES,YES,res[@"data"][@"httpUrl"]);
                                                 }else {
                                                     padding(NO,YES,res[@"data"][@"httpUrl"]);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 padding(NO,NO,@"error");

                                             } ];
}

+ (BOOL) isReleaseVersion {
    // 正式 com.mvc.cryptovault https://www.bzvp.net/api/app/
    // 测试 N-NSTechnology.ToPay http://47.110.234.233:10086/
    return  ([[QuickGet getBundleIdStr] isEqualToString:@"com.mvc.cryptovault"]);
}
@end
