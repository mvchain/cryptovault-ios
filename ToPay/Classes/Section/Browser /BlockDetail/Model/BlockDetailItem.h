//
//    BlockDetailItem.h
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockDetailItem : NSObject

@property (nonatomic, assign) NSInteger confirm;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, strong) NSString * yhash;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger transactionId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
