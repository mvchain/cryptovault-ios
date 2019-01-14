//
//  TPRgeisterViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/11.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPRegisterInfoModel.h"
@interface TPRgeisterViewModel : NSObject
#pragma mark property
/**
 * 一次性token
 */

@property (copy,nonatomic) TPRegisterInfoModel *regInfoModel;

#pragma mark http service

// 发送验证码
- (void)sendVaildCodeByEmail:(NSString *)emailAddr
                    complete:(void(^)(BOOL isSucc))complete;

// 去服务器验证注册信息（邀请码，短信验证码 etc..）
- (void)userWithEmail:(NSString *)email
           inviteCode:(NSString *)inviteCode
            vaildCode:(NSString *)vaildCode
             complete:(void(^)(BOOL isSucc,NSString *token,NSString *message))complete;


#pragma mark logic
// 本地判断注册信息是否合法
- (void)isRegisterParameterCorrect:(NSString *)invitedCode
                          nickName:(NSString *)nickName
                             email:(NSString *)email
                         vaildCode:(NSString *)vaildCode
                       quickResult:(void(^)(BOOL isVaild,NSString *resonInf))quickResult;

@end


