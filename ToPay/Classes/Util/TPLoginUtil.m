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
             NSDictionary *dic = responseObject[@"data"];
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
             TPExchangeRate *ratioM = exchanges[0];
             [USER_DEFAULT setObject:ratioM.value forKey:TPNowLegalCurrencyKey];
             [USER_DEFAULT setObject:[ratioM.name substringToIndex:1] forKey:TPNowLegalSymbolKey];
             [USER_DEFAULT setObject:ratioM.name forKey:TPNowLegalNameKey];
             
             [TPNotificationCenter postNotificationName:TPLegalSwitchNotification object:nil];
             
         }
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"获取法币汇率失败 %@",error);
     }];
}
+ (void)setRequestToken:(NSString *)token  {
    [[WYNetworkConfig sharedConfig] addCustomHeader:@{
                                                      @"Authorization":token,
                                                      @"Accept-Language":@"zh-cn"
                                                      }];
    
}

+ (void)refreshToken:(void (^)(bool isSucc))status {
    if ([TPLoginUtil isLogin] == NO)
    {
        [USER_DEFAULT setObject:@"1" forKey:TPNowLegalCurrencyKey];
        [USER_DEFAULT setObject:@"￥" forKey:TPNowLegalSymbolKey];
        return ;
    }
    [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":[TPLoginUtil userInfo].refreshToken}];
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/refresh" parameters:nil success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             TPLoginModel *loginM = [TPLoginUtil userInfo];
             loginM.token = responseObject[@"data"];
             [TPLoginUtil saveUserInfo:loginM];
             [TPLoginUtil setRequestToken:loginM.token];
             [TPLoginUtil requestExchangeRate];
             status(YES);
             
         }else {
             status(NO);
         }
     }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"刷新token失败");
     }];
}

+ (void)loginInitSetting:(TPLoginModel *)model {
    [QuickDo setJPushAlians:model.userId]; //极光的设置
    [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":model.token,@"Accept-Language":@"zh-cn"}];
    // Store user information
    [TPLoginUtil saveUserInfo:model];
    // Basic user information
    [TPLoginUtil setRequestInfo];
    // Get currency list
    [TPLoginUtil setRequestToken];
    [TPLoginUtil requestExchangeRate];
}
+ (void)refreshToken_if_err_logout {
    
    NSInteger lastTime = 0 ;
    NSNumber *lastTime_number =  [[NSUserDefaults standardUserDefaults] objectForKey:kTokenLastTimeFetch];
    if (lastTime_number) {
        lastTime = [lastTime_number integerValue];
    }
    NSDate *cur = [NSDate date];
    if([cur timeIntervalSince1970] - lastTime < 10 *60) return; //10分钟内
    if(![TPLoginUtil isLogin]) return; // 尚未登陆
    [TPLoginUtil refreshToken:^(bool isSucc) {
        if (!isSucc) {
            [QuickDo logout];
        }else {
              [[NSUserDefaults standardUserDefaults] setObject:@([cur timeIntervalSince1970]) forKey:kTokenLastTimeFetch];
        }
    }];
}
@end
