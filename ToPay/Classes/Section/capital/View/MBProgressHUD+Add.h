//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;



//只显示文字（默认时间是1.2秒）
+(void)showWithText:(NSString *)text view:(UIView *)view;

//只显示文字
+(void)showWithText:(NSString *)text   afterDelay:(NSTimeInterval)delay view:(UIView *)view;


@end
