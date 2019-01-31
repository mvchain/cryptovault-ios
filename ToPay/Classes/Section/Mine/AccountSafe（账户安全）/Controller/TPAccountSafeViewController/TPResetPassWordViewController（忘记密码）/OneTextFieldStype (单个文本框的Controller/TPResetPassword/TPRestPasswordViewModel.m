//
//  TPRestPasswordViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRestPasswordViewModel.h"

@implementation TPRestPasswordViewModel

- (NSString *)HintTitle {
    NSString *pwdtype = [[NSUserDefaults standardUserDefaults]objectForKey:kResetPwdType]; // 1 登录，2 支付
    return [pwdtype isEqualToString:@"1"]?@"设置登录密码":@"设置支付密码";
}

- (NSString *)buttonTitle {
    return @"确认重置";
}
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeASCIICapable;
}
- (NSString *)placeHolder {
    return @"登录密码";
}
- (BOOL)isPasswdType {
    return YES;
}
- (void)submitWithValue:(NSString *)value
               complete:(void(^)(BOOL isSucc ,NSString *info,id data))complete {
    NSString *pwdtype = [[NSUserDefaults standardUserDefaults]objectForKey:kResetPwdType]; // 1 登录，2 支付
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:kForgetPwdEmail];
    NSDictionary *postDict = @{@"password":[QuickGet encryptPwd:value email:email],@"token":self.onceToken,@"type":pwdtype};
    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer
                                                 url:@"user/forget"
                                          parameters:postDict
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     complete(YES,nil,nil);
                                                 }else {
                                                     complete(NO,res[@"message"],nil);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 NSLog(@"%@",[error description]);
                                                 complete(NO,@"网络错误",nil);
                                             } ];
}
@end
