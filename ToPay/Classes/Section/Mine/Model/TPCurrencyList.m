//
//  TPCurrencyList.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCurrencyList.h"

@implementation TPCurrencyList

MJCodingImplementation

+ (NSDictionary *)objectClassInArray
{
    return @{@"data" : [CLData class]};
}

@end



@implementation CLData
MJCodingImplementation
@end
