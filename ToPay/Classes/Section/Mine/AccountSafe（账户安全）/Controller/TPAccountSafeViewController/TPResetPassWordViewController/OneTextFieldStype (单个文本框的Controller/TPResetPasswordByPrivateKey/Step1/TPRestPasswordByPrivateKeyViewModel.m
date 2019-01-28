//
//  TPRestPasswordByPrivateKeyViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRestPasswordByPrivateKeyViewModel.h"

@implementation TPRestPasswordByPrivateKeyViewModel

- (NSString *)HintTitle {
    return @"私钥验证";
}

- (NSString *)buttonTitle {
    return @"下一步";
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeDefault;
}

- (NSString *)placeHolder {
    return @"输入私钥";
}

- (BOOL) isPasswdType {
    return NO;
    
}

- (void)submitWithValue:(NSString *)value
               complete:(void (^)(BOOL, NSString *ifno,id data))complete {
    NSDictionary *postDict = @{@"resetType":@1,@"value":value};
    /**
     {
     "code": 0,
     "data": "string",
     "message": "string"
     }
     */
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/reset"
                                           parameters:postDict
                                              success:^(id responseObject, BOOL isCacheObject) {
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                                  if ([res[@"code"] intValue] == 200) {
                                                      self.onceToken = res[@"data"];
                                                      complete(YES,nil,nil);
                                                  }else {
                                                      complete(NO,res[@"message"],nil);
                                                  }
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  complete(NO,@"网络错误",nil);
                                                  
                                              }];
}

@end
