//
//    BlockTransactionRecordItem.h
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockTransactionRecordItem : NSObject

@property (nonatomic, assign) NSInteger classify;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger idField;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
