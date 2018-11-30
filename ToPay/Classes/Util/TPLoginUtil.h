//
//  TPLoginUtil.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPLoginModel.h"
@interface TPLoginUtil : NSObject

/*
 * 请求币种列表
 */
+(void)setRequestToken;

/*
 * 请求币种比值
 */
+(void)setRequestTokenBase;

/*
 *  保存-用户-信息
 */
+(void)saveUserInfo:(TPLoginModel *)userInfo;

/*
 *  取出-用户-信息
 */
+ (TPLoginModel *)userInfo;

+(BOOL)quitWithRemoveUserInfo;

+(BOOL)isLogin;

@end
