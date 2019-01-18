//
//  TPResetPassWordByEmailViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPResetPassWordByEmailViewModel : NSObject
@property (copy, nonatomic) NSString *onceToken;

- (void)sendVaildCodeByEmail:(NSString *)emailAddr
                    complete:(void(^)(BOOL isSucc))complete;

- (void)resetWithEmail:(NSString *)email
             vaildCode:(NSString *)vaildCode
              complete:(void(^)(BOOL isSucc,NSString *info))complete ;

@end


