//
//  TPRgeisterViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/11.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRgeisterViewModel.h"

@implementation TPRgeisterViewModel
#pragma mark lazy load
- (TPRegisterInfoModel *)regInfoModel {
    
    if( !_regInfoModel ) {
        _regInfoModel = [[TPRegisterInfoModel alloc] init];
    }
    return _regInfoModel;
}

#pragma mark http service'
/**
 * 发送验证码，邮箱
 */
- (void)sendVaildCodeByEmail:(NSString *)emailAddr
                    complete:(void(^)(BOOL isSucc))complete {
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"user/email/logout"
                                          parameters:@{@"email":emailAddr}
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

/**
 * 校验验证码信息，以便下一步
 * 本方法会获得一次性token，并放入到self.regInfoModel.token，以方便后续注册使用
 */
- (void)userWithEmail:(NSString *)email
           inviteCode:(NSString *)inviteCode
            vaildCode:(NSString *)vaildCode
             complete:(void(^)(BOOL isSucc,NSString *token,NSString *message))complete {
    
    NSDictionary *postDict = @{@"email":email,
                               @"inviteCode":inviteCode,
                               @"valiCode":vaildCode};
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user"
                                           parameters:postDict
                                              success:^(id responseObject, BOOL isCacheObject) {
                                                  
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                                  if ([res[@"code"] intValue] == 200 ) {
                                                      self.regInfoModel.token = res[@"data"]; // 设置临时token
                                                       complete(YES,res[@"data"],res[@"message"]);
                                                  }else {
                                                       complete(NO,nil,res[@"message"]);
                                                  }
    }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  complete(NO,nil,@"网络错误");
    }];
    
}

#pragma mark custom logic

/**
 * 合法性判断（email 格式，是否为空，etc... ）
 */
- (void)isRegisterParameterCorrect:(NSString *)invitedCode
                          nickName:(NSString *)nickName
                             email:(NSString *)email
                         vaildCode:(NSString *)vaildCode
                       quickResult:(void(^)(BOOL isVaild,NSString *resonInf))quickResult {
    if (!quickResult)return;
    
    if (invitedCode.length == 0) {
        quickResult(NO,@"邀请码不能为空");
        return ;
    }
    if (nickName.length == 0) {
        quickResult(NO,@"昵称不能为空");
        return ;
    }
    if (email.length == 0) {
        quickResult(NO,@"邮箱不能为空");
        return ;
    }
    if (vaildCode.length == 0) {
        quickResult(NO,@"验证码不能为空");
        return ;
    }
    if (![JudegeCenter isAvailableEmail:email]) {
        quickResult(NO,@"邮箱格式不正确！");
        return ;
    }
    quickResult(YES,nil); // 合法
}


@end
