//
//  TPBindEmailViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPBindEmailViewModel : NSObject
@property (copy ,nonatomic) NSString *oneceToken;
- (void)sendVaildCodeByEmail:(NSString *)emailAddr
                    complete:(void(^)(BOOL isSucc))complete;

- (void)rebindEmail:(NSString *)email
              token:(NSString *)token
           valiCode:(NSString *)valiCode
           complete:(void (^)(BOOL isSucc,NSString *info)) complete;

@end

