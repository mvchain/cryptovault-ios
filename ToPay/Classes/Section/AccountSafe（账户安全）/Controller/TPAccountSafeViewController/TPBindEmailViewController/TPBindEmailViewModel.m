//
//  TPBindEmailViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBindEmailViewModel.h"
#import "TPRgeisterViewModel.h"
@implementation TPBindEmailViewModel
- (void)sendVaildCodeByEmail:(NSString *)emailAddr
                    complete:(void(^)(BOOL isSucc))complete {
    TPRgeisterViewModel *reg = [[TPRgeisterViewModel alloc] init];
    [reg sendVaildCodeByEmail:emailAddr complete:complete];
    
}

- (void)rebindEmail:(NSString *)email
              token:(NSString *)token
           valiCode:(NSString *)valiCode
           complete:(void (^)(BOOL isSucc,NSString *info))complete {
    NSDictionary *postDict = @{@"email":email,@"token":token,@"valiCode":valiCode};
    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer
                                                 url:@"user/email"
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
