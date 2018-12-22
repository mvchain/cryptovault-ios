//
//  TPLoginUtil.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPLoginUtil.h"
#import "TPCurrencyList.h"
#import "TPCurrencyRatio.h"
#import "TPUserInfo.h"
#import "TPExchangeRate.h"
#define loginFileName @"loginUser.plist"
#define TPFilePathWithName(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]
#define loginFilePath TPFilePathWithName(loginFileName)


@implementation TPLoginUtil

+(void)saveUserInfo:(TPLoginUtil *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:TPFilePathWithName(loginFileName)];
}

+ (TPLoginUtil *)userInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:TPFilePathWithName(loginFileName)];
}

+(BOOL)quitWithRemoveUserInfo
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:TPFilePathWithName(loginFileName) error:nil];
}

+(BOOL)isLogin
{
    return [self userInfo] == nil? NO:YES;
}


+(void)setRequestToken
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"token" success:^(id responseObject, BOOL isCacheObject)
    {
        TPCurrencyList *currencyList = [TPCurrencyList mj_objectWithKeyValues:responseObject];
        
        YYCache *listCache = [YYCache cacheWithName:TPCacheName];
       
        [listCache setObject:currencyList forKey:TPCurrencyListKey];
        for (int i = 0 ; i <currencyList.data.count ; i++)
        {
            CLData *clData = currencyList.data[i];
            
            [listCache setObject:clData forKey:currencyList.data[i].tokenId];
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"请求币种列表失败：error = %@", error);
    }];
}

+(void)setRequestTokenBase
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"token/base" success:^(id responseObject, BOOL isCacheObject)
    {
        NSLog(@"responseObject = %@", responseObject);
        
        NSArray<TPCurrencyRatio *> *currencyRatio = [TPCurrencyRatio mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        YYCache *listCache = [YYCache cacheWithName:TPCacheName];
        [listCache setObject:currencyRatio forKey:TPCurrencyRatioKey];
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"error = %@", error);
    }];
}

+(void)setRequestInfo
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"user/info" success:^(id responseObject, BOOL isCacheObject)
    {
        NSLog(@"data:%@",responseObject[@"data"]);
        TPUserInfo *TPInfo = [TPUserInfo mj_objectWithKeyValues:responseObject[@"data"]];

        YYCache *listCache = [YYCache cacheWithName:TPCacheName];
        [listCache setObject:TPInfo forKey:TPUserInfoKey];
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"获取用户信息失败：error = %@", error);
    }];
}

+(void)requestExchangeRate
{
    [[WYNetworkManager  sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"token/exchange/rate" success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"%@",responseObject[@"data"]);
             NSArray<TPExchangeRate *> *exchanges = [TPExchangeRate mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             
             
             NSLog(@"%@",responseObject[@"data"]);
             
             YYCache *listCache = [YYCache cacheWithName:TPCacheName];
             [listCache setObject:exchanges forKey:TPLegalCurrencyListKey];
             
             for (int i = 0 ; i <exchanges.count ; i++)
             {
                 TPExchangeRate *exRate = exchanges[i];
                 [listCache setObject:exRate.value forKey:exRate.name];
             }
         }
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"获取法币汇率失败 %@",error);
     }];
}


@end
