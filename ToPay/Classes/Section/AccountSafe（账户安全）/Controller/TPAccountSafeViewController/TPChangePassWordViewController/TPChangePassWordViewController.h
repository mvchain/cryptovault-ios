//
//  TPChangePassWordViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

/**
 * 改变（支付/登录）密码
 */

@protocol TPChangePassWordViewModelProtocol <NSObject>
@required
- (NSString *)passWordTypeName ;
- (UIKeyboardType)textFieldKeyboardType;
- (void)changePassWdWithOldPassWd:(NSString *)old
                        newPassWd:(NSString *)newPassWd
                         complete:(void(^)(BOOL isSucc,NSString *info))complete;
@end

@interface TPChangePassWordViewController : TPBaseViewController
@property (strong, nonatomic) id<TPChangePassWordViewModelProtocol> viewModel;

@end


