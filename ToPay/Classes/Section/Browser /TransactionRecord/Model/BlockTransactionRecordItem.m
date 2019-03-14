//
//    BlockTransactionRecordItem.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockTransactionRecordItem.h"

NSString *const kBlockTransactionRecordItemClassify = @"classify";
NSString *const kBlockTransactionRecordItemCreatedAt = @"createdAt";
NSString *const kBlockTransactionRecordItemIdField = @"id";

@interface BlockTransactionRecordItem ()
@end
@implementation BlockTransactionRecordItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockTransactionRecordItemClassify] isKindOfClass:[NSNull class]]){
        self.classify = [dictionary[kBlockTransactionRecordItemClassify] integerValue];
    }
    
    if(![dictionary[kBlockTransactionRecordItemCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kBlockTransactionRecordItemCreatedAt] integerValue];
    }
    
    if(![dictionary[kBlockTransactionRecordItemIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kBlockTransactionRecordItemIdField] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockTransactionRecordItemClassify] = @(self.classify);
    dictionary[kBlockTransactionRecordItemCreatedAt] = @(self.createdAt);
    dictionary[kBlockTransactionRecordItemIdField] = @(self.idField);
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.classify) forKey:kBlockTransactionRecordItemClassify];    [aCoder encodeObject:@(self.createdAt) forKey:kBlockTransactionRecordItemCreatedAt];    [aCoder encodeObject:@(self.idField) forKey:kBlockTransactionRecordItemIdField];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.classify = [[aDecoder decodeObjectForKey:kBlockTransactionRecordItemClassify] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kBlockTransactionRecordItemCreatedAt] integerValue];
    self.idField = [[aDecoder decodeObjectForKey:kBlockTransactionRecordItemIdField] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockTransactionRecordItem *copy = [BlockTransactionRecordItem new];
    
    copy.classify = self.classify;
    copy.createdAt = self.createdAt;
    copy.idField = self.idField;
    
    return copy;
}
@end
