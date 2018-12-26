//
//  NSObject+TPExtension.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TPExtension)

-(NSString *)getNowTimeTimestamp;

-(NSString *)conversionTimeStamp;

/*
 * 时间戳 转 NSDate
 */
- (NSDate *)getLocateTime:(double)timeStamp;
-(NSString *)dateConversionTimeStamp:(NSDate *)date;

-(NSString *)MDConversionTimeStamp;

-(long long)longLongFromDate;

- (BOOL)isMobileNumber:(NSString *)mobileNum;

-(BOOL)isETH:(NSString *)ethString;
//^(0x)?[0-9a-fA-F]{40}$
-(BOOL)isBTC:(NSString *)btcString;

@end
