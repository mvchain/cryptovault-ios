//
//  QuickMaker.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/4.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickMaker : NSObject
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size ;
+ (NSString *)makeCnDayHourMinuteSecWithTimeCuo:(long long  )time;
+ (CGFloat)makeFloatNumber:(CGFloat) num tailNum:(int)tailNum ; // 制作 保留tailNum位的不四舍五入的小数
+ (NSString *)timeWithTimeIntervalString:(NSInteger)time;
+ (NSString *)timeWithTimeInterval_allNumberStyleString:( NSInteger)time;
+ (NSString *)timeWithFormat:(NSString *)formt time:(NSInteger)time ;
/// json-str 转 dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSData *)postDataFromDictionary:(NSDictionary *)dictionary ;

@end

