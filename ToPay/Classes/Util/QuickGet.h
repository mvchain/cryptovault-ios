//
//  QuickGet.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/9.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QuickGet : NSObject
+ (NSString *)getLegalCurrency;
+ (CGFloat )getWhiteBottomHeight ;
+ (NSString *)getMd5:(NSString *)md5;
+ (NSString *)encryptPwd:(NSString *)pwd email:(NSString *)m_email ;

@end


