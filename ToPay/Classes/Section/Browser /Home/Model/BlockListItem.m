//
//    BlockListItem.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockListItem.h"

NSString *const kBlockListItemBlockId = @"blockId";
NSString *const kBlockListItemCreatedAt = @"createdAt";
NSString *const kBlockListItemTransactions = @"transactions";

@interface BlockListItem ()
@end
@implementation BlockListItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockListItemBlockId] isKindOfClass:[NSNull class]]){
        self.blockId = [dictionary[kBlockListItemBlockId] integerValue];
    }
    
    if(![dictionary[kBlockListItemCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kBlockListItemCreatedAt] integerValue];
    }
    
    if(![dictionary[kBlockListItemTransactions] isKindOfClass:[NSNull class]]){
        self.transactions = [dictionary[kBlockListItemTransactions] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockListItemBlockId] = @(self.blockId);
    dictionary[kBlockListItemCreatedAt] = @(self.createdAt);
    dictionary[kBlockListItemTransactions] = @(self.transactions);
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
    [aCoder encodeObject:@(self.blockId) forKey:kBlockListItemBlockId];    [aCoder encodeObject:@(self.createdAt) forKey:kBlockListItemCreatedAt];    [aCoder encodeObject:@(self.transactions) forKey:kBlockListItemTransactions];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.blockId = [[aDecoder decodeObjectForKey:kBlockListItemBlockId] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kBlockListItemCreatedAt] integerValue];
    self.transactions = [[aDecoder decodeObjectForKey:kBlockListItemTransactions] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockListItem *copy = [BlockListItem new];
    
    copy.blockId = self.blockId;
    copy.createdAt = self.createdAt;
    copy.transactions = self.transactions;
    
    return copy;
}
@end
