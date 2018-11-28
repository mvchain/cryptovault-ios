//
//  TPSellViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/26.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPStartViewController.h"
@class BalanceHeaderView;
@interface TPSellViewController : TPStartViewController

@end


@interface BalanceHeaderView : UIView

- (instancetype)initWithTitle:(NSString *)title WithAmount:(NSString *)amount;

@end
