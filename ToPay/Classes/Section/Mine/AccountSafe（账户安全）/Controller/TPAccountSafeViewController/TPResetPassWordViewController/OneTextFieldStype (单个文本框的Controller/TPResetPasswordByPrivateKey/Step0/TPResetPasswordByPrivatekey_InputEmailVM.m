//
//  TPResetPasswordByPrivatekey_InputEmailVM.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/28.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPResetPasswordByPrivatekey_InputEmailVM.h"

@implementation TPResetPasswordByPrivatekey_InputEmailVM
- (NSString *)HintTitle {
    return @"输入邮箱账户";
}

- (NSString *)buttonTitle {
    return @"下一步";
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeEmailAddress;
}

- (NSString *)placeHolder {
    return @"邮箱";
}
- (BOOL) isPasswdType {
    
    return NO ;
    
}
- (void)submitWithValue:(NSString *)value
               complete:(void(^)(BOOL isSucc ,NSString *info,id data))complete {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:kForgetPwdEmail];
    complete(YES,nil,nil);
    
}

@end
