//
//  TPLoginModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLoginModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString * email;
@property (nonatomic, assign) NSInteger googleCheck;
@property (nonatomic, strong) NSString * publicKey;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic, strong) NSString * salt;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger userId;


@end
