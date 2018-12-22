//
//  TPTransferModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/19.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTransferModel : NSObject

@property (nonatomic , copy) NSString              * balance;
@property (nonatomic)    double            fee;
@property (nonatomic , copy) NSString              * feeTokenName;

@end

NS_ASSUME_NONNULL_END
