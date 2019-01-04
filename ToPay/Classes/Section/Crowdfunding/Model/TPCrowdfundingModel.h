//
//  TPCrowdfundingModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/12.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCrowdfundingModel : NSObject

@property (nonatomic , copy) NSString              * projectName;
@property (nonatomic , copy) NSString              * updatedAt;
@property (nonatomic ) NSTimeInterval               stopAt;
@property (nonatomic , copy) NSString              * total;
@property (nonatomic , copy) NSString              * ratio;
@property (nonatomic , copy) NSString              * projectImage;
@property (nonatomic , copy) NSString              * projectLimit;
@property (nonatomic , copy) NSString              * baseTokenId;
@property (nonatomic , copy) NSString              * startedAt;
@property (nonatomic , copy) NSString              * baseTokenName;
@property (nonatomic , copy) NSString              * releaseValue;
@property (nonatomic , copy) NSString              * projectId;
@property (nonatomic , copy) NSString              * tokenId;
@property (nonatomic , copy) NSString              * createdAt;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * tokenName;
@property (nonatomic ,copy) NSString * displayType;
@end

NS_ASSUME_NONNULL_END
