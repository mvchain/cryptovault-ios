//
//  QuickGet.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/9.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "QuickGet.h"
#import "TPExchangeRate.h"
#import <CommonCrypto/CommonDigest.h>
#import "TPLoginUtil.h"
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

+ (CGFloat )getWhiteBottomHeight {
    if( [JudegeCenter isIphoneX] )
        return 52+39;
    else
        return 52;
    
}
+ (NSString *)encryptPwd:(NSString *)pwd salt:(NSString *)m_salt  {
    //Md5(“邮箱” + Md5(“密码/交易密码”))
    NSString *salt =  m_salt?m_salt:TPLoginUtil.userInfo.salt;
    NSString *inMd5 = [self md5:pwd];
    NSString *finalMd5 = [[self md5:TPString(@"%@%@",salt,[inMd5 uppercaseString])] uppercaseString];
    return finalMd5;

}

+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
+ (NSString *)getCurVersion  {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
+ (NSString *)getCurBuildVersion {
   //  CFBundleVersion
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}
+ (NSString *)getBundleIdStr {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}
// 服务器
+ (NSString *)getCurrentServerUrl {
    //https://www.ttpay-tech.com/api/app
    NSString *release_url = @"https://www.ttpay-tech.com/api/app/";
    NSString *test_url = @"http://47.110.234.233:10086/";
    NSString *this_cur = [JudegeCenter isReleaseVersion]?release_url:test_url;
    return this_cur;
}
// 理财网页
+ (NSString *)getFinancingProductDetailWebDomainUrl {
    NSString *release_url = @"http://47.110.234.233/wv/";
    NSString *test_url = @"http://47.110.234.233/wv/";
    NSString *this_cur = [JudegeCenter isReleaseVersion]?release_url:test_url;
    return this_cur;
}
// 区块链浏览器
+ (NSString *)getExplorerPath {
    //@"http://47.110.234.233/api/explorer";
    //@"http://192.168.15.21:10081";
    NSString *test =@"http://47.110.234.233/api/explorer";
    NSString *release = @"https://www.ttpay-tech.com/api/explorer";
    NSString *this_cur = [JudegeCenter isReleaseVersion]?release:test;
    return this_cur;
}
+ (NSString *)httpPathWithCurrentServerUrl:(NSString *)path {
    return TPString(@"%@%@",[self getCurrentServerUrl],path);
}
+ (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
