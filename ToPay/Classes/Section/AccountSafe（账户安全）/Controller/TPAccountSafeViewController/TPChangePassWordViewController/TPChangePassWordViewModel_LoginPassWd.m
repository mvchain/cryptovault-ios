//
//  TPChangePassWordViewModel_LoginPassWd.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPChangePassWordViewModel_LoginPassWd.h"

@implementation TPChangePassWordViewModel_LoginPassWd

- (void)changePassWdWithOldPassWd:(NSString *)old
                        newPassWd:(NSString *)newPassWd
                         complete:(void (^)(BOOL, NSString *))complete {
    
}

- (NSString *)passWordTypeName {
    return @"登录密码";
    
}

@end
