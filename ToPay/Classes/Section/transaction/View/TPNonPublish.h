//
//  TPNonPublish.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTransactionModel.h"
//#import "TPTransInfoModel.h"
@interface TPNonPublish : UIView

- (instancetype)initWithTransType:(TPTransactionType)transType tokenName:(NSString *)tokenName currName:(NSString *)currName;

@property (nonatomic, strong) TPTransactionModel *transModel;


@end
