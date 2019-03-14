//
//  TransactionRecordDetailViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransactionRecordDetailViewController : TPBaseViewController
@property (assign,nonatomic) NSInteger classify;
@property (assign,nonatomic) NSInteger transactionId;
@end

NS_ASSUME_NONNULL_END
