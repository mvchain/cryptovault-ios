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
+ (NSString *)encryptPwd:(NSString *)pwd email:(NSString *)m_email  {
    //Md5(“邮箱” + Md5(“密码/交易密码”))
    NSString *email =   m_email?m_email:TPLoginUtil.userInfo.email;
    NSString *inMd5 = [self md5:pwd];
    NSString *finalMd5 = [[self md5:TPString(@"%@%@",email,[inMd5 uppercaseString])] uppercaseString];
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

+ (NSString *)getCurrentServerUrl {
    NSString *release_url = @"https://www.bzvp.net/api/app/";
    NSString *test_url = @"http://192.168.15.21:10086/";
    NSString *this_cur = [JudegeCenter isReleaseVersion]?release_url:test_url;
    return this_cur;
}

+ (NSString *)httpPathWithCurrentServerUrl:(NSString *)path {
    return TPString(@"%@%@",[self getCurrentServerUrl],path);
}
@end
