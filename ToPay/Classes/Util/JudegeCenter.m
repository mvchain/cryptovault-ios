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

@end
