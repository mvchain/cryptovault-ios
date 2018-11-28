//
//  TPTransView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/28.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPasswordView.h"
@class TPTransView;
@class TransTextView;
@interface TPTransView : UIView

+(TPTransView *)createTransferView;

-(void)showMenuWithAlpha:(BOOL)isShow;


@property (nonatomic, strong) SYPasswordView * pasView;

@end


@interface TransTextView : UIView


-(instancetype)initWithTitle:(NSString *)title WithCon:(NSString *)con;
@end
