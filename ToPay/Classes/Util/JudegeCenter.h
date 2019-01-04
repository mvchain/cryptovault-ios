//
//  JudegeCenter.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/3.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JudegeCenter : NSObject
+(BOOL)isETH:(NSString *)ethString;
+(BOOL)isBTC:(NSString *)btcString;
+ (BOOL)isVaildAddrWithTokenId:(NSString *)tokenId addr:(NSString *)addr ;

@end


