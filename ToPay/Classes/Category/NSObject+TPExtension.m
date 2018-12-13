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


-(long long)longLongFromDate
{
    NSDate * dat = [NSDate date];
    return [dat timeIntervalSinceDate:dat] * 1000;
}

@end
