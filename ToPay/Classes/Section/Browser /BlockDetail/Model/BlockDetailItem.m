//
//    BlockDetailItem.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockDetailItem.h"

NSString *const kBlockDetailItemConfirm = @"confirm";
NSString *const kBlockDetailItemCreatedAt = @"createdAt";
NSString *const kBlockDetailItemHash = @"hash";
NSString *const kBlockDetailItemHeight = @"height";
NSString *const kBlockDetailItemTransactionId = @"transactionId";

@interface BlockDetailItem ()
@end
@implementation BlockDetailItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockDetailItemConfirm] isKindOfClass:[NSNull class]]){
        self.confirm = [dictionary[kBlockDetailItemConfirm] integerValue];
    }
    
    if(![dictionary[kBlockDetailItemCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kBlockDetailItemCreatedAt] integerValue];
    }
    
    if(![dictionary[kBlockDetailItemHash] isKindOfClass:[NSNull class]]){
        self.yhash = dictionary[kBlockDetailItemHash];
    }
    if(![dictionary[kBlockDetailItemHeight] isKindOfClass:[NSNull class]]){
        self.height = [dictionary[kBlockDetailItemHeight] integerValue];
    }
    
    if(![dictionary[kBlockDetailItemTransactionId] isKindOfClass:[NSNull class]]){
        self.transactionId = [dictionary[kBlockDetailItemTransactionId] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockDetailItemConfirm] = @(self.confirm);
    dictionary[kBlockDetailItemCreatedAt] = @(self.createdAt);
    if(self.yhash != nil){
        dictionary[kBlockDetailItemHash] = self.yhash;
    }
    dictionary[kBlockDetailItemHeight] = @(self.height);
    dictionary[kBlockDetailItemTransactionId] = @(self.transactionId);
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
    [aCoder encodeObject:@(self.confirm) forKey:kBlockDetailItemConfirm];    [aCoder encodeObject:@(self.createdAt) forKey:kBlockDetailItemCreatedAt];    if(self.yhash != nil){
        [aCoder encodeObject:self.yhash forKey:kBlockDetailItemHash];
    }
    [aCoder encodeObject:@(self.height) forKey:kBlockDetailItemHeight];    [aCoder encodeObject:@(self.transactionId) forKey:kBlockDetailItemTransactionId];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.confirm = [[aDecoder decodeObjectForKey:kBlockDetailItemConfirm] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kBlockDetailItemCreatedAt] integerValue];
    self.yhash = [aDecoder decodeObjectForKey:kBlockDetailItemHash];
    self.height = [[aDecoder decodeObjectForKey:kBlockDetailItemHeight] integerValue];
    self.transactionId = [[aDecoder decodeObjectForKey:kBlockDetailItemTransactionId] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockDetailItem *copy = [BlockDetailItem new];
    
    copy.confirm = self.confirm;
    copy.createdAt = self.createdAt;
    copy.yhash = [self.yhash copy];
    copy.height = self.height;
    copy.transactionId = self.transactionId;
    
    return copy;
}
@end
