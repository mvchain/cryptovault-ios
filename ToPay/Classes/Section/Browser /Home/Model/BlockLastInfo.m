//
//    BlockLastInfo.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockLastInfo.h"

NSString *const kBlockLastInfoBlockId = @"blockId";
NSString *const kBlockLastInfoConfirmTime = @"confirmTime";
NSString *const kBlockLastInfoServiceTime = @"serviceTime";
NSString *const kBlockLastInfoTotal = @"total";
NSString *const kBlockLastInfoTransactionCount = @"transactionCount";
NSString *const kBlockLastInfoVersion = @"version";

@interface BlockLastInfo ()
@end
@implementation BlockLastInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockLastInfoBlockId] isKindOfClass:[NSNull class]]){
        self.blockId = [dictionary[kBlockLastInfoBlockId] integerValue];
    }
    
    if(![dictionary[kBlockLastInfoConfirmTime] isKindOfClass:[NSNull class]]){
        self.confirmTime = [dictionary[kBlockLastInfoConfirmTime] integerValue];
    }
    
    if(![dictionary[kBlockLastInfoServiceTime] isKindOfClass:[NSNull class]]){
        self.serviceTime = [dictionary[kBlockLastInfoServiceTime] integerValue];
    }
    
    if(![dictionary[kBlockLastInfoTotal] isKindOfClass:[NSNull class]]){
        self.total = [dictionary[kBlockLastInfoTotal] integerValue];
    }
    
    if(![dictionary[kBlockLastInfoTransactionCount] isKindOfClass:[NSNull class]]){
        self.transactionCount = [dictionary[kBlockLastInfoTransactionCount] integerValue];
    }
    
    if(![dictionary[kBlockLastInfoVersion] isKindOfClass:[NSNull class]]){
        self.version = dictionary[kBlockLastInfoVersion];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockLastInfoBlockId] = @(self.blockId);
    dictionary[kBlockLastInfoConfirmTime] = @(self.confirmTime);
    dictionary[kBlockLastInfoServiceTime] = @(self.serviceTime);
    dictionary[kBlockLastInfoTotal] = @(self.total);
    dictionary[kBlockLastInfoTransactionCount] = @(self.transactionCount);
    if(self.version != nil){
        dictionary[kBlockLastInfoVersion] = self.version;
    }
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
    [aCoder encodeObject:@(self.blockId) forKey:kBlockLastInfoBlockId];    [aCoder encodeObject:@(self.confirmTime) forKey:kBlockLastInfoConfirmTime];    [aCoder encodeObject:@(self.serviceTime) forKey:kBlockLastInfoServiceTime];    [aCoder encodeObject:@(self.total) forKey:kBlockLastInfoTotal];    [aCoder encodeObject:@(self.transactionCount) forKey:kBlockLastInfoTransactionCount];    if(self.version != nil){
        [aCoder encodeObject:self.version forKey:kBlockLastInfoVersion];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.blockId = [[aDecoder decodeObjectForKey:kBlockLastInfoBlockId] integerValue];
    self.confirmTime = [[aDecoder decodeObjectForKey:kBlockLastInfoConfirmTime] integerValue];
    self.serviceTime = [[aDecoder decodeObjectForKey:kBlockLastInfoServiceTime] integerValue];
    self.total = [[aDecoder decodeObjectForKey:kBlockLastInfoTotal] integerValue];
    self.transactionCount = [[aDecoder decodeObjectForKey:kBlockLastInfoTransactionCount] integerValue];
    self.version = [aDecoder decodeObjectForKey:kBlockLastInfoVersion];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockLastInfo *copy = [BlockLastInfo new];
    
    copy.blockId = self.blockId;
    copy.confirmTime = self.confirmTime;
    copy.serviceTime = self.serviceTime;
    copy.total = self.total;
    copy.transactionCount = self.transactionCount;
    copy.version = [self.version copy];
    
    return copy;
}
@end
