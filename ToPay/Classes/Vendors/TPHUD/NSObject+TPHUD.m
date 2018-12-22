//
//  NSObject+TPHUD.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/19.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "NSObject+TPHUD.h"

@implementation NSObject (TPHUD)

- (void)showText:(NSString *)aText
{
    [TProgressHUD showWithStatus:aText];
    [TProgressHUD dismissWithDelay:2];
}


- (void)showErrorText:(NSString *)aText
{
    [TProgressHUD showErrorWithStatus:aText];
    [TProgressHUD dismissWithDelay:2];
}

- (void)showSuccessText:(NSString *)aText
{
    [TProgressHUD showSuccessWithStatus:aText];
    [TProgressHUD dismissWithDelay:2];
}

- (void)showInfoText:(NSString *)aText
{
    [TProgressHUD showInfoWithStatus:aText];
    [TProgressHUD dismissWithDelay:2];
}

- (void)showLoading
{
    [TProgressHUD show];
}


- (void)dismissLoading
{
    [TProgressHUD dismiss];
}

- (void)showProgress:(NSInteger)progress
{
    [TProgressHUD showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
    [TProgressHUD dismissWithDelay:2];
}

- (void)showImage:(UIImage*)image text:(NSString*)aText
{
    [TProgressHUD showImage:image status:aText];
    [TProgressHUD dismissWithDelay:2];
}

@end
