//
//    BlockDetailInfo.h
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockDetailInfo : NSObject

@property (nonatomic, assign) NSInteger blockId;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger transactions;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
