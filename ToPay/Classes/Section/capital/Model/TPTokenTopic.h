//
//  TPTokenTopic.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/5.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPTokenTopic : NSObject

@property (nonatomic) NSInteger classify;

@property (nonatomic, copy) NSString *createdAt;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *ratio;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *tokenId;

@property (nonatomic, copy) NSString *tokenName;

@property (nonatomic, copy) NSString *transactionType;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, copy) NSString *value;

@end
