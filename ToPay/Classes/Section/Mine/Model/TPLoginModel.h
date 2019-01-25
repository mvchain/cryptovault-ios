//
//  TPLoginModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLoginModel : NSObject <NSCoding>

@property (nonatomic , copy) NSString         * refreshToken;
@property (nonatomic , copy) NSString         * token;
@property (nonatomic , copy) NSString         * userId;
@property (nonatomic ,copy) NSString * email;


//  @property (nonatomic , copy) NSString         * nickname;
//  @property (nonatomic , copy) NSString         * birthday;
//  @property (nonatomic , copy) NSString         * invite_code;
//  @property (nonatomic , copy) NSString         * sex;

@end
