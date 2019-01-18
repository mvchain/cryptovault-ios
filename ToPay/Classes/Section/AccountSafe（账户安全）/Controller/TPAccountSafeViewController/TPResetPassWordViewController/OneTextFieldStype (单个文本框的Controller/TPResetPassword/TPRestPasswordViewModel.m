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
    return @"设置登录密码";
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

- (void)submitWithValue:(NSString *)value
               complete:(void(^)(BOOL isSucc ,NSString *info))complete {
    NSString *pwdtype = [[NSUserDefaults standardUserDefaults]objectForKey:@"reset-pwd-type"];
    
    NSDictionary *postDict = @{@"password":value,@"token":self.onceToken,@"type":pwdtype};
    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer
                                                 url:@"/user/forget"
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
@end
