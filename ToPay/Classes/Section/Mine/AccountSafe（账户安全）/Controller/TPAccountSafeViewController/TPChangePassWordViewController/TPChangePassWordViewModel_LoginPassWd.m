//
//  TPChangePassWordViewModel_LoginPassWd.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPChangePassWordViewModel_LoginPassWd.h"

@implementation TPChangePassWordViewModel_LoginPassWd

- (void)changePassWdWithOldPassWd:(NSString *)old
                        newPassWd:(NSString *)newPassWd
                         complete:(void (^)(BOOL isSucc, NSString *ifno))complete {
    
    NSDictionary *postDict = @{@"password":[QuickGet encryptPwd:old email:nil],
                               @"newPassword":[QuickGet encryptPwd:newPassWd email:nil]};
    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer
                                                 url:@"user/password"
                                          parameters:postDict
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     complete(YES,nil);
                                                 }else {
                                                     complete(NO,res[@"message"]);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 NSLog(@"%@",[error description]);
                                                 complete(NO,@"网络错误");
                                             } ];
}

// 密码类型名
- (NSString *)passWordTypeName {
    return @"登录密码";
}
// 键盘类型
- (UIKeyboardType)textFieldKeyboardType {
    return UIKeyboardTypeAlphabet;
}
@end
