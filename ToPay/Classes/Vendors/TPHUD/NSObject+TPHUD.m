//
//  NSObject+TPHUD.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/19.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "NSObject+TPHUD.h"
#import "MBProgressHUD+Add.h"
@implementation NSObject (TPHUD)

- (void)showText:(NSString *)aText
{
    [MBProgressHUD showMessag:aText toView:nil];
    
//    [TProgressHUD showWithStatus:aText];
//    [TProgressHUD dismissWithDelay:1];
}


- (void)showErrorText:(NSString *)aText
{
      [MBProgressHUD showError:aText toView:nil];
//    [TProgressHUD showErrorWithStatus:aText];
//    [TProgressHUD dismissWithDelay:1];
}

- (void)showSuccessText:(NSString *)aText
{
    [MBProgressHUD showSuccess:aText toView:nil];
    
//    [TProgressHUD showSuccessWithStatus:aText];
//    [TProgressHUD dismissWithDelay:1];
}

- (void)showInfoText:(NSString *)aText
{
    [MBProgressHUD showWithText:aText view:nil];
    
//    [TProgressHUD showInfoWithStatus:aText];
//    [TProgressHUD dismissWithDelay:1];
}

- (void)showLoading
{
    //[TProgressHUD show];
}


- (void)dismissLoading
{
    //[TProgressHUD dismiss];
}
- (void)yu_showLoading {
    [TProgressHUD show];
}

- (void)yu_dismissLoading {
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
