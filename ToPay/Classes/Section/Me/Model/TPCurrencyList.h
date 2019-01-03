//
//  TPCurrencyList.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLData;
@interface TPCurrencyList : NSObject <NSCoding>

@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSArray<CLData *>              * data;
@property (nonatomic , copy) NSString              * code;

@end


@interface CLData :NSObject  <NSCoding>
@property (nonatomic , copy) NSString              * tokenCnName;
@property (nonatomic , copy) NSString              * timestamp;
@property (nonatomic , copy) NSString              * tokenEnName;
@property (nonatomic , copy) NSString              * tokenImage;
@property (nonatomic , copy) NSString              * tokenId;
@property (nonatomic , copy) NSString              * tokenName;
@property (nonatomic , copy) NSString              * tokenType;
@end
