//
//  TPKLineModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/24.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPKLineModel : NSObject

@property (nonatomic , copy) NSArray<NSString *>              * timeX;
@property (nonatomic , copy) NSArray<NSString *>              * valueY;

@end

NS_ASSUME_NONNULL_END
