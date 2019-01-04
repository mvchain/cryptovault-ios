//
//  TPCroRecordModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/12.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCroRecordModel : NSObject

@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * projectName;
@property (nonatomic , copy) NSString              * successPayed;
@property (nonatomic , copy) NSString              * projectOrderId;
@property (nonatomic , copy) NSString              * stopAt;
@property (nonatomic , copy) NSString              * publishAt;
@property (nonatomic , copy) NSString              * ratio;
@property (nonatomic , copy) NSString              * reservationType;
@property (nonatomic , copy) NSString              * successValue;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic , copy) NSString              * projectId;
@property (nonatomic , copy) NSString              * baseTokenName;
@property (nonatomic , copy) NSString              * releaseValue;
@property (nonatomic , copy) NSString              * tokenId;
@property (nonatomic , copy) NSString              * createdAt;
@property (nonatomic , copy) NSString              * tokenName;
@property (nonatomic , copy) NSString              * displayType;

@end

NS_ASSUME_NONNULL_END
