//
//  TPRestPasswordByMnmonicViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRestPasswordByMnmonicViewModel.h"

@implementation TPRestPasswordByMnmonicViewModel

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
- (BOOL)isPasswdType {
    return NO;
}
- (void)submitWithValue:(NSString *)value
               complete:(void(^)(BOOL isSucc ,NSString *info,id data))complete {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:kForgetPwdEmail];
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"user/mnemonics"
                                          parameters:@{@"email":value}
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     complete(YES,nil,res[@"data"]);
                                                 }else {
                                                     complete(NO,nil,nil);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 NSLog(@"%@",[error description]);
                                                 complete(NO,nil,nil);
                                             } ];
}

@end
