//
//  TPTokenTopicViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//


#import "TPStartViewController.h"

typedef NS_ENUM(NSInteger, TPTransactionType)
{
    TPTransactionTypeAll,
    TPTransactionTypeTransfer,
    TPTransactionTypeTransferOut,
};


@interface TPTokenTopicViewController : TPStartViewController

- (instancetype)initWithTokenId:(NSString *)tokenId WithTransactionType:(TPTransactionType)type;

@end
