//
//    BlockLastInfo.h
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockLastInfo : NSObject

@property (nonatomic, assign) NSInteger blockId;
@property (nonatomic, assign) NSInteger confirmTime;
@property (nonatomic, assign) NSInteger serviceTime;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger transactionCount;
@property (nonatomic, strong) NSString * version;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
