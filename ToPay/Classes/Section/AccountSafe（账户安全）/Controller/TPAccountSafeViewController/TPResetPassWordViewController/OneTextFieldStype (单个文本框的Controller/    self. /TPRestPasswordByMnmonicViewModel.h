//
//  TPRestPasswordByMnmonicViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPResetPwdOneTextFiledViewController.h"

@interface TPRestPasswordByMnmonicViewModel : NSObject<TPResetPwdOneTextFiledViewModelProtocol>
@property (copy, nonatomic) NSString *onceToken;
@property (copy, nonatomic) NSString *emial;
@end


