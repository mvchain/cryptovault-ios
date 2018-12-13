//
//  TPSellViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/26.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPStartViewController.h"
#import "TPTokenTopicViewController.h"
@class BalanceHeaderView;
@interface TPSellViewController : TPStartViewController


@property (nonatomic, strong) NSString *orderId;

- (instancetype)initWithPairId:(NSString *)pairId WithTransType:(TPTransactionType)transType;



@end


@interface BalanceHeaderView : UIView

@property (nonatomic, strong) UILabel * titLab;
@property (nonatomic, strong) UILabel * amountLab;

- (instancetype)initWithTitle:(NSString *)title WithAmount:(NSString *)amount;

@end
