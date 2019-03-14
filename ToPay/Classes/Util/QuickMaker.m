//
//  QuickMaker.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/4.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "QuickMaker.h"
#import <Photos/Photos.h>

@implementation QuickMaker
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (NSString *)makeCnDayHourMinuteSecWithTimeCuo:(long long )time {
    
    long long day = time / ( 24 * 60 * 60 );
    long long rest_sec = time % ( 24 * 60 * 60 ) ;
    long long hour = rest_sec / (60 * 60);
    rest_sec = rest_sec % (60 * 60);
    long long mintue =  rest_sec / 60;
    rest_sec = rest_sec % 60 ;
    NSString *res ;
    if( day > 0 ) {
        res = TPString(@"%lld天%lld小时%lld分钟%lld秒",day,hour,mintue,rest_sec);
    }else if( hour > 0  ) {
        res = TPString(@"%lld小时%lld分钟%lld秒",hour,mintue,rest_sec);
    }else if ( mintue >0  ) {
        res = TPString(@"%lld分钟%lld秒",mintue,rest_sec);
    }else {
        res = TPString(@"%lld秒",rest_sec);
    }
    return res;
}
+ (NSString *)timeWithTimeIntervalString:( NSInteger)time
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeInterval_allNumberStyleString:( NSInteger)time
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
  + (NSString *)timeWithFormat:(NSString *)formt time:(NSInteger)time  {
      // 格式化时间
      NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
      formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
      [formatter setDateStyle:NSDateFormatterMediumStyle];
      [formatter setTimeStyle:NSDateFormatterShortStyle];
      [formatter setDateFormat:formt];
      // 毫秒值转化为秒
      NSDate* date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
      NSString* dateString = [formatter stringFromDate:date];
      return dateString;
}
+ (CGFloat)makeFloatNumber:(CGFloat) num tailNum:(int)tailNum {
    int sum = 10 ;
    while (--tailNum) {
        sum*=10;
    }
    int res_int =  (int)(num * sum);
    return res_int / (CGFloat)sum;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSData *)postDataFromDictionary:(NSDictionary *)dictionary {
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in dictionary) {
        NSString *string = [NSString stringWithFormat:@"%@=%@",key,dictionary[key]];
        [mArray addObject:string];
    }
    NSString *newString = [mArray componentsJoinedByString:@"&"];
    return [newString dataUsingEncoding:NSUTF8StringEncoding];
}
@end
