//
//  TPTransDetailModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTransDetailModel : NSObject

@property (nonatomic , copy) NSString              * blockHash;
@property (nonatomic , copy) NSString              * updatedAt;
@property (nonatomic , copy) NSString              * classify;
@property (nonatomic , copy) NSString              * hashLink;
@property (nonatomic , copy) NSString              * fee;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic , copy) NSString              * orderRemark;
@property (nonatomic , copy) NSString              * fromAddress;
@property (nonatomic , copy) NSString              * feeTokenType;
@property (nonatomic , copy) NSString              * toAddress;
@property (nonatomic , copy) NSString              * createdAt;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * tokenName;
@property (nonatomic ,copy) NSString *transactionType;

@end

NS_ASSUME_NONNULL_END
