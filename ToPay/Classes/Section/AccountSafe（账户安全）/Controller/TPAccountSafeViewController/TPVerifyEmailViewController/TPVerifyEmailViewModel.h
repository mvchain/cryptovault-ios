//
//  TPVerifyEmailViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPVerifyEmailViewModel : NSObject


- (NSString *)currentEmail;

- (void)sendVaildCodeWithcomplete:(void(^)(BOOL isSucc))complete ;


- (void)checkoutWithVaildCode:(NSString *)vaildCode
                     complete:(void(^)(BOOL isVaild,NSString *token))complete;

@end


