//
//  QuickGet.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/9.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "QuickGet.h"
#import "TPExchangeRate.h"
@implementation QuickGet
+ (NSString *)getLegalCurrency {
    NSString *str = [USER_DEFAULT objectForKey:TPNowLegalNameKey];
    if( !str ) {
        YYCache *listCache = [YYCache cacheWithName:TPCacheName];
        NSArray <TPExchangeRate *>*listArr = (NSArray<TPExchangeRate *> *)[listCache objectForKey:TPLegalCurrencyListKey];
        NSString *name = listArr[0].name;
        name = [name substringFromIndex:1];
        str = name ;
        
    }
    return str;
    
}
@end
