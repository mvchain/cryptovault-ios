//
//    TransactionRecordDetailInfo.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TransactionRecordDetailInfo.h"

NSString *const kTransactionRecordDetailInfoBuyTokenId = @"buyTokenId";
NSString *const kTransactionRecordDetailInfoBuyTokenName = @"buyTokenName";
NSString *const kTransactionRecordDetailInfoBuyValue = @"buyValue";
NSString *const kTransactionRecordDetailInfoClassify = @"classify";
NSString *const kTransactionRecordDetailInfoCreatedAt = @"createdAt";
NSString *const kTransactionRecordDetailInfoFrom = @"from";
NSString *const kTransactionRecordDetailInfoSellTokenId = @"sellTokenId";
NSString *const kTransactionRecordDetailInfoSellTokenName = @"sellTokenName";
NSString *const kTransactionRecordDetailInfoSellValue = @"sellValue";
NSString *const kTransactionRecordDetailInfoTo = @"to";

@interface TransactionRecordDetailInfo ()
@end
@implementation TransactionRecordDetailInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kTransactionRecordDetailInfoBuyTokenId] isKindOfClass:[NSNull class]]){
        self.buyTokenId = [dictionary[kTransactionRecordDetailInfoBuyTokenId] integerValue];
    }
    
    if(![dictionary[kTransactionRecordDetailInfoBuyTokenName] isKindOfClass:[NSNull class]]){
        self.buyTokenName = dictionary[kTransactionRecordDetailInfoBuyTokenName];
    }
    if(![dictionary[kTransactionRecordDetailInfoBuyValue] isKindOfClass:[NSNull class]]){
        self.buyValue = [dictionary[kTransactionRecordDetailInfoBuyValue] doubleValue];
    }
    
    if(![dictionary[kTransactionRecordDetailInfoClassify] isKindOfClass:[NSNull class]]){
        self.classify = [dictionary[kTransactionRecordDetailInfoClassify] integerValue];
    }
    
    if(![dictionary[kTransactionRecordDetailInfoCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kTransactionRecordDetailInfoCreatedAt] integerValue];
    }
    
    if(![dictionary[kTransactionRecordDetailInfoFrom] isKindOfClass:[NSNull class]]){
        self.from = dictionary[kTransactionRecordDetailInfoFrom];
    }
    if(![dictionary[kTransactionRecordDetailInfoSellTokenId] isKindOfClass:[NSNull class]]){
        self.sellTokenId = [dictionary[kTransactionRecordDetailInfoSellTokenId] integerValue];
    }
    
    if(![dictionary[kTransactionRecordDetailInfoSellTokenName] isKindOfClass:[NSNull class]]){
        self.sellTokenName = dictionary[kTransactionRecordDetailInfoSellTokenName];
    }
    if(![dictionary[kTransactionRecordDetailInfoSellValue] isKindOfClass:[NSNull class]]){
        self.sellValue = [dictionary[kTransactionRecordDetailInfoSellValue] doubleValue];
    }
    
    if(![dictionary[kTransactionRecordDetailInfoTo] isKindOfClass:[NSNull class]]){
        self.to = dictionary[kTransactionRecordDetailInfoTo];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kTransactionRecordDetailInfoBuyTokenId] = @(self.buyTokenId);
    if(self.buyTokenName != nil){
        dictionary[kTransactionRecordDetailInfoBuyTokenName] = self.buyTokenName;
    }
    dictionary[kTransactionRecordDetailInfoBuyValue] = @(self.buyValue);
    dictionary[kTransactionRecordDetailInfoClassify] = @(self.classify);
    dictionary[kTransactionRecordDetailInfoCreatedAt] = @(self.createdAt);
    if(self.from != nil){
        dictionary[kTransactionRecordDetailInfoFrom] = self.from;
    }
    dictionary[kTransactionRecordDetailInfoSellTokenId] = @(self.sellTokenId);
    if(self.sellTokenName != nil){
        dictionary[kTransactionRecordDetailInfoSellTokenName] = self.sellTokenName;
    }
    dictionary[kTransactionRecordDetailInfoSellValue] = @(self.sellValue);
    if(self.to != nil){
        dictionary[kTransactionRecordDetailInfoTo] = self.to;
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
    [aCoder encodeObject:@(self.buyTokenId) forKey:kTransactionRecordDetailInfoBuyTokenId];    if(self.buyTokenName != nil){
        [aCoder encodeObject:self.buyTokenName forKey:kTransactionRecordDetailInfoBuyTokenName];
    }
    [aCoder encodeObject:@(self.buyValue) forKey:kTransactionRecordDetailInfoBuyValue];    [aCoder encodeObject:@(self.classify) forKey:kTransactionRecordDetailInfoClassify];    [aCoder encodeObject:@(self.createdAt) forKey:kTransactionRecordDetailInfoCreatedAt];    if(self.from != nil){
        [aCoder encodeObject:self.from forKey:kTransactionRecordDetailInfoFrom];
    }
    [aCoder encodeObject:@(self.sellTokenId) forKey:kTransactionRecordDetailInfoSellTokenId];    if(self.sellTokenName != nil){
        [aCoder encodeObject:self.sellTokenName forKey:kTransactionRecordDetailInfoSellTokenName];
    }
    [aCoder encodeObject:@(self.sellValue) forKey:kTransactionRecordDetailInfoSellValue];    if(self.to != nil){
        [aCoder encodeObject:self.to forKey:kTransactionRecordDetailInfoTo];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.buyTokenId = [[aDecoder decodeObjectForKey:kTransactionRecordDetailInfoBuyTokenId] integerValue];
    self.buyTokenName = [aDecoder decodeObjectForKey:kTransactionRecordDetailInfoBuyTokenName];
    self.buyValue = [[aDecoder decodeObjectForKey:kTransactionRecordDetailInfoBuyValue] doubleValue];
    self.classify = [[aDecoder decodeObjectForKey:kTransactionRecordDetailInfoClassify] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kTransactionRecordDetailInfoCreatedAt] integerValue];
    self.from = [aDecoder decodeObjectForKey:kTransactionRecordDetailInfoFrom];
    self.sellTokenId = [[aDecoder decodeObjectForKey:kTransactionRecordDetailInfoSellTokenId] integerValue];
    self.sellTokenName = [aDecoder decodeObjectForKey:kTransactionRecordDetailInfoSellTokenName];
    self.sellValue = [[aDecoder decodeObjectForKey:kTransactionRecordDetailInfoSellValue] doubleValue];
    self.to = [aDecoder decodeObjectForKey:kTransactionRecordDetailInfoTo];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    TransactionRecordDetailInfo *copy = [TransactionRecordDetailInfo new];
    
    copy.buyTokenId = self.buyTokenId;
    copy.buyTokenName = [self.buyTokenName copy];
    copy.buyValue = self.buyValue;
    copy.classify = self.classify;
    copy.createdAt = self.createdAt;
    copy.from = [self.from copy];
    copy.sellTokenId = self.sellTokenId;
    copy.sellTokenName = [self.sellTokenName copy];
    copy.sellValue = self.sellValue;
    copy.to = [self.to copy];
    
    return copy;
}
@end
