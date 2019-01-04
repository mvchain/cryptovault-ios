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
    if ([tokenId isEqualToString:@"4"])
    {
        return  [self isBTC:addr] ;
    }
        return  [self isETH:addr] ;
}
@end
