//
//  TPResetPwdOneTextFiledViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

/**
 * 只有一个文本框，一个按钮的界面
 */

@protocol TPResetPwdOneTextFiledViewModelProtocol <NSObject>

@required
- (void)submitWithValue:(NSString *)value
               complete:(void(^)(BOOL isSucc ,NSString *info))complete;

- (UIKeyboardType )keyboardType;
- (NSString *)buttonTitle;
- (NSString *)placeHolder;
- (NSString *)HintTitle;


@end
@interface TPResetPwdOneTextFiledViewController : TPBaseViewController
@property (strong,nonatomic) id<TPResetPwdOneTextFiledViewModelProtocol> viewModel;


@end


