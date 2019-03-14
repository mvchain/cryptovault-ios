//
//    BlockTransactionInfo.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockTransactionInfo.h"

NSString *const kBlockTransactionInfoConfirm = @"confirm";
NSString *const kBlockTransactionInfoCreatedAt = @"createdAt";
NSString *const kBlockTransactionInfoHash = @"hash";
NSString *const kBlockTransactionInfoHeight = @"height";
NSString *const kBlockTransactionInfoTransactionId = @"transactionId";

@interface BlockTransactionInfo ()
@end
@implementation BlockTransactionInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockTransactionInfoConfirm] isKindOfClass:[NSNull class]]){
        self.confirm = [dictionary[kBlockTransactionInfoConfirm] integerValue];
    }
    
    if(![dictionary[kBlockTransactionInfoCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kBlockTransactionInfoCreatedAt] integerValue];
    }
    
    if(![dictionary[kBlockTransactionInfoHash] isKindOfClass:[NSNull class]]){
        self.yhash = dictionary[kBlockTransactionInfoHash];
    }
    if(![dictionary[kBlockTransactionInfoHeight] isKindOfClass:[NSNull class]]){
        self.height = [dictionary[kBlockTransactionInfoHeight] integerValue];
    }
    
    if(![dictionary[kBlockTransactionInfoTransactionId] isKindOfClass:[NSNull class]]){
        self.transactionId = [dictionary[kBlockTransactionInfoTransactionId] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockTransactionInfoConfirm] = @(self.confirm);
    dictionary[kBlockTransactionInfoCreatedAt] = @(self.createdAt);
    if(self.yhash != nil){
        dictionary[kBlockTransactionInfoHash] = self.yhash;
    }
    dictionary[kBlockTransactionInfoHeight] = @(self.height);
    dictionary[kBlockTransactionInfoTransactionId] = @(self.transactionId);
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
    [aCoder encodeObject:@(self.confirm) forKey:kBlockTransactionInfoConfirm];    [aCoder encodeObject:@(self.createdAt) forKey:kBlockTransactionInfoCreatedAt];    if(self.yhash != nil){
        [aCoder encodeObject:self.yhash forKey:kBlockTransactionInfoHash];
    }
    [aCoder encodeObject:@(self.height) forKey:kBlockTransactionInfoHeight];    [aCoder encodeObject:@(self.transactionId) forKey:kBlockTransactionInfoTransactionId];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.confirm = [[aDecoder decodeObjectForKey:kBlockTransactionInfoConfirm] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kBlockTransactionInfoCreatedAt] integerValue];
    self.yhash = [aDecoder decodeObjectForKey:kBlockTransactionInfoHash];
    self.height = [[aDecoder decodeObjectForKey:kBlockTransactionInfoHeight] integerValue];
    self.transactionId = [[aDecoder decodeObjectForKey:kBlockTransactionInfoTransactionId] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockTransactionInfo *copy = [BlockTransactionInfo new];
    
    copy.confirm = self.confirm;
    copy.createdAt = self.createdAt;
    copy.yhash = [self.yhash copy];
    copy.height = self.height;
    copy.transactionId = self.transactionId;
    
    return copy;
}
@end
