//
//  TPRgeisterViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/11.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPRgeisterViewModel : NSObject
- (void)registerUserWithInvitedCode:(NSString *)invitedCode
                           nickName:(NSString *)nickName
                              email:(NSString *)email
                          vaildCode:(NSString *)vaildCode;

@end

NS_ASSUME_NONNULL_END
