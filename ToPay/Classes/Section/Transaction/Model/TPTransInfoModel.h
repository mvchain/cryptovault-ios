//
//  TPTransInfoModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTransInfoModel : NSObject

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, copy) NSString *max;

@property (nonatomic, copy) NSString *min;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *tokenBalance;

@property (nonatomic, copy) NSString *value;

@end

NS_ASSUME_NONNULL_END
