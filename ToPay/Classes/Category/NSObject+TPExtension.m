//
//  NSObject+TPExtension.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "NSObject+TPExtension.h"

@implementation NSObject (TPExtension)

-(NSString *)getNowTimeTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f",a];
    
    return timeString;
}


-(NSString *)conversionTimeStamp
{
    NSTimeInterval interval    =[(NSString *)self doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
//    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
}

-(NSString *)MDConversionTimeStamp
{
    NSTimeInterval interval    =[(NSString *)self doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
    //    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
}


-(long long)longLongFromDate
{
    NSDate * dat = [NSDate date];
    return [dat timeIntervalSinceDate:dat] * 1000;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    //    电信号段:133/153/180/181/189/177
    
    //    联通号段:130/131/132/155/156/185/186/145/176
    
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|9[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

-(BOOL)isETH:(NSString *)ethString
{
    NSString *MOBILE = @"^(0x)?[0-9a-fA-F]{40}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:ethString];
}

-(BOOL)isBTC:(NSString *)btcString
{
    NSString *MOBILE = @"^[123mn][a-zA-Z1-9]{24,34}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:btcString];
}

- (NSDate *)getLocateTime:(double)timeStamp
{
    timeStamp = timeStamp / 1000.0;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return confromTimesp;
}

-(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}



@end
