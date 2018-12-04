//
//  TPVRTViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"


typedef NS_ENUM(NSInteger, TPTransactionStyle)
{
    TPTransactionStyleVRT,
    TPTransactionStyleBalance,
};


@interface TPVRTViewController : TPBaseViewController

- (instancetype) initWithChainStyle:( TPTransactionStyle )transactionStyle;

@end
