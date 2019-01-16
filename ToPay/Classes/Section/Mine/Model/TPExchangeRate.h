//
//  TPExchangeRate.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/8.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPExchangeRate : NSObject <NSCoding>

@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * value;

@end


