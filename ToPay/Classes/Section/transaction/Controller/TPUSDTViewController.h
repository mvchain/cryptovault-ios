//
//  TPUSDTViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPStartViewController.h"
#import "TPCurrencyList.h"
@interface TPUSDTViewController : TPStartViewController

@property (nonatomic, strong) CLData *cData;
@property (nonatomic, copy) NSString * tokenName;
@property (nonatomic, copy) NSString * currName;
- (instancetype)initWithPairId:(NSString *)pairId WithTransactionType:(NSString *)transactionType;

@end
