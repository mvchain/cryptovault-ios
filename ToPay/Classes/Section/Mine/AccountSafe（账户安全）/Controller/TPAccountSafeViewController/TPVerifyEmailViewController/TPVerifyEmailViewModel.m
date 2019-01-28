//
//  TPVerifyEmailViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPVerifyEmailViewModel.h"
#import "TPRgeisterViewModel.h"
#import "TPUserInfo.h"

@implementation TPVerifyEmailViewModel
- (NSString *)currentEmail {
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    
    TPUserInfo *userInfo = (TPUserInfo *)[listCache objectForKey:TPUserInfoKey];
    return userInfo.username;
    
}

- (void)sendVaildCodeWithcomplete:(void(^)(BOOL isSucc))complete {
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"user/email"
                                          parameters:nil
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     complete(YES);
                                                 }else {
                                                     complete(NO);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 NSLog(@"%@",[error description]);
                                                 complete(NO);
                                             } ];
}

- (void)checkoutWithVaildCode:(NSString *)vaildCode
                     complete:(void(^)(BOOL isVaild,NSString *token))complete {
    NSDictionary *postDict = @{@"valiCode":vaildCode};
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/email"
                                           parameters:postDict
                                              success:^(id responseObject, BOOL isCacheObject) {
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                                  if ([res[@"code"] intValue] == 200 ) {
                                                      complete(YES,res[@"data"]);
                                                  }else {
                                                     complete(NO,nil);
                                                  }
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  complete(NO,nil);
                                              }];
}
@end
