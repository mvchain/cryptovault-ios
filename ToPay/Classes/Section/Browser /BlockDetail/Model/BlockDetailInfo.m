//
//    BlockDetailInfo.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockDetailInfo.h"

NSString *const kBlockDetailInfoBlockId = @"blockId";
NSString *const kBlockDetailInfoCreatedAt = @"createdAt";
NSString *const kBlockDetailInfoTransactions = @"transactions";

@interface BlockDetailInfo ()
@end
@implementation BlockDetailInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockDetailInfoBlockId] isKindOfClass:[NSNull class]]){
        self.blockId = [dictionary[kBlockDetailInfoBlockId] integerValue];
    }
    
    if(![dictionary[kBlockDetailInfoCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kBlockDetailInfoCreatedAt] integerValue];
    }
    
    if(![dictionary[kBlockDetailInfoTransactions] isKindOfClass:[NSNull class]]){
        self.transactions = [dictionary[kBlockDetailInfoTransactions] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockDetailInfoBlockId] = @(self.blockId);
    dictionary[kBlockDetailInfoCreatedAt] = @(self.createdAt);
    dictionary[kBlockDetailInfoTransactions] = @(self.transactions);
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
    [aCoder encodeObject:@(self.blockId) forKey:kBlockDetailInfoBlockId];    [aCoder encodeObject:@(self.createdAt) forKey:kBlockDetailInfoCreatedAt];    [aCoder encodeObject:@(self.transactions) forKey:kBlockDetailInfoTransactions];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.blockId = [[aDecoder decodeObjectForKey:kBlockDetailInfoBlockId] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kBlockDetailInfoCreatedAt] integerValue];
    self.transactions = [[aDecoder decodeObjectForKey:kBlockDetailInfoTransactions] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockDetailInfo *copy = [BlockDetailInfo new];
    
    copy.blockId = self.blockId;
    copy.createdAt = self.createdAt;
    copy.transactions = self.transactions;
    
    return copy;
}
@end
