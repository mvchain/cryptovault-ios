//
//    MyStoreDetailBigInfoModel.h
//
//    Create by 蒲公英 on 23/1/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStoreDetailBigInfoModel : NSObject

@property (nonatomic, strong) NSString * baseTokenName;
@property (nonatomic, strong) NSString * financialName;
@property (nonatomic, assign) CGFloat income;
@property (nonatomic, assign) CGFloat incomeMax;
@property (nonatomic, assign) CGFloat incomeMin;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) CGFloat value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
