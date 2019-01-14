//
//  TPSetPasswordViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPSetPasswordViewModel.h"
#import "TPRegisterResponseModel.h"
@implementation TPSetPasswordViewModel
/**
 * 注册成功后会缓存regInfoModel
 *
 * /user/register
 * 用户注册,需要将之前的信息和token一起带入进行校验
 */
- (void)registerWithRegInfoModel:(TPRegisterInfoModel *)regInfoModel
                        complete:(void(^)(BOOL isSucc,NSString *reasonInfo))complete {
    NSDictionary *postDict = [regInfoModel toDictionary];
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/register"
                                           parameters:postDict
                                              success:^(id responseObject, BOOL isCacheObject) {
                                                  
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                            
                                                  if ([res[@"code"] intValue] == 200 ) {
                                                      TPRegisterResponseModel *responseData = [[TPRegisterResponseModel alloc] initWithDictionary:res[@"data"]];
                                                      [self setRegResponseToCache:responseData];
                                                      [self setRegInfoModelToCache:self.regInfoModel];
                                                     complete(YES,res[@"注册成功"]);
                                                  }else {
                                                    complete(NO,TPString(@"错误：%@",res[@"message"]));
                                                  }
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  complete(NO,@"网络错误");
                                              }];

}
#pragma mark local method

- (void)isPassWordVaildWithPassWd:(NSString *)passWd
                        payPassWd:(NSString *)payPassWd
                      quickResult:(void(^)(BOOL isVaild,NSString *reasonInf))quickResult {
    if (passWd.length == 0) {
        quickResult(NO,@"密码不能为空");
        return;
    }
    if (payPassWd.length == 0) {
        quickResult(NO,@"登录支付密码");
        return;
    }
    quickResult(YES,nil);
}
/**
 * 注册信息缓存
 */
- (void)setRegInfoModelToCache:(TPRegisterInfoModel *)infoModel {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    [cache setObject:infoModel forKey:kReginfoModelCacheKey];
}

/**
 * 注册后服务器反馈的信息缓存
 */
- (void)setRegResponseToCache:(TPRegisterResponseModel *)response {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    [cache setObject:response forKey:kRegResponseCacheKey];
}
@end
