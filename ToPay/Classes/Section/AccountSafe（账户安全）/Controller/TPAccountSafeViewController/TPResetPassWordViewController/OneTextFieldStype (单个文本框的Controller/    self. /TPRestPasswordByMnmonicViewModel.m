//
//  TPRestPasswordByMnmonicViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRestPasswordByMnmonicViewModel.h"

@implementation TPRestPasswordByMnmonicViewModel

- (NSString *)HintTitle { 
    return @"输入邮箱账户";
}

- (NSString *)buttonTitle { 
    return @"下一步";
}

- (UIKeyboardType)keyboardType { 
    return UIKeyboardTypeEmailAddress;
}

- (NSString *)placeHolder { 
    return @"邮箱";
}

- (void)submitWithValue:(NSString *)value
               complete:(void (^)(BOOL, NSString *))complete {
    complete(YES,nil); // 助记词
}

@end
