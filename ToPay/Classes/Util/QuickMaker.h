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

@end

