//
//  TPResetPassWordByEmailViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPResetPassWordByEmailViewModel.h"
#import "TPRgeisterViewModel.h"
#import "TPVerifyEmailViewModel.h"
@implementation TPResetPassWordByEmailViewModel
- (void)sendVaildCodeByEmail:(NSString *)emailAddr
                    complete:(void(^)(BOOL isSucc))complete {
    TPRgeisterViewModel  *model = [[TPRgeisterViewModel alloc] init];
    [model sendVaildCodeByEmail:emailAddr complete:complete];
    
}
/**
 email    string
 邮箱
 
 resetType    integer($int32)
 重置类型0邮箱 1私钥 2助记词
 
 value    string
 校验字段
 
 }
 */
- (void)resetWithEmail:(NSString *)email
             vaildCode:(NSString *)vaildCode
              complete:(void(^)(BOOL isSucc,NSString *info))complete  {
    NSDictionary *postDict = @{@"email":email,@"resetType":@0,@"value":vaildCode};
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:kForgetPwdEmail]; //缓存临时邮箱
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
                                                      complete(YES,nil);
                                                  }else {
                                                      complete(NO,res[@"message"]);
                                                  }
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  complete(NO,@"网络错误");
                                                  
                                              }];
}

@end
