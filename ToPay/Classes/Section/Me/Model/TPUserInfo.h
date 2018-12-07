//
//  TPUserInfo.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/7.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPUserInfo : NSObject <NSCoding>

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *headImage;

@property (nonatomic, strong) NSString *nickname;

@end


