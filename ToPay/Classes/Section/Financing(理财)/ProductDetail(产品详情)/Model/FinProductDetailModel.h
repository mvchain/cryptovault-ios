//
//    FinProductDetailModel.h
//
//    Create by 蒲公英 on 10/4/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinProductDetailModel : NSObject

@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) NSInteger baseTokenId;
@property (nonatomic, strong) NSString * baseTokenName;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat incomeMax;
@property (nonatomic, assign) CGFloat incomeMin;
@property (nonatomic, assign) CGFloat limitValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) CGFloat purchased;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSString * rule;
@property (nonatomic, assign) CGFloat sold;
@property (nonatomic, assign) NSInteger startAt;
@property (nonatomic, assign) NSInteger stopAt;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) NSInteger tokenId;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) CGFloat userLimit;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
