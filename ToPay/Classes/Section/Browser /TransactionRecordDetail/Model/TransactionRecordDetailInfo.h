//
//    TransactionRecordDetailInfo.h
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionRecordDetailInfo : NSObject

@property (nonatomic, assign) NSInteger buyTokenId;
@property (nonatomic, strong) NSString * buyTokenName;
@property (nonatomic, assign) CGFloat buyValue;
@property (nonatomic, assign) NSInteger classify;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, strong) NSString * from;
@property (nonatomic, assign) NSInteger sellTokenId;
@property (nonatomic, strong) NSString * sellTokenName;
@property (nonatomic, assign) CGFloat sellValue;
@property (nonatomic, strong) NSString * to;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
