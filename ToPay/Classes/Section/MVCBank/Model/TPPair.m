//
//    TPPair.m
//
//    Create by 蒲公英 on 4/4/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TPPair.h"

NSString *const kTPPairIncrease = @"increase";
NSString *const kTPPairPair = @"pair";
NSString *const kTPPairPairId = @"pairId";
NSString *const kTPPairRatio = @"ratio";
NSString *const kTPPairTokenId = @"tokenId";
NSString *const kTPPairTokenImage = @"tokenImage";
NSString *const kTPPairTokenName = @"tokenName";
NSString *const kTPPairTransactionStatus = @"transactionStatus";

@interface TPPair ()
@end
@implementation TPPair




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kTPPairIncrease] isKindOfClass:[NSNull class]]){
        self.increase = [dictionary[kTPPairIncrease] integerValue];
    }
    
    if(![dictionary[kTPPairPair] isKindOfClass:[NSNull class]]){
        self.pair = dictionary[kTPPairPair];
    }
    if(![dictionary[kTPPairPairId] isKindOfClass:[NSNull class]]){
        self.pairId = [dictionary[kTPPairPairId] integerValue];
    }
    
    if(![dictionary[kTPPairRatio] isKindOfClass:[NSNull class]]){
        self.ratio = [dictionary[kTPPairRatio] integerValue];
    }
    
    if(![dictionary[kTPPairTokenId] isKindOfClass:[NSNull class]]){
        self.tokenId = [dictionary[kTPPairTokenId] integerValue];
    }
    
    if(![dictionary[kTPPairTokenImage] isKindOfClass:[NSNull class]]){
        self.tokenImage = dictionary[kTPPairTokenImage];
    }
    if(![dictionary[kTPPairTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kTPPairTokenName];
    }
    if(![dictionary[kTPPairTransactionStatus] isKindOfClass:[NSNull class]]){
        self.transactionStatus = [dictionary[kTPPairTransactionStatus] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kTPPairIncrease] = @(self.increase);
    if(self.pair != nil){
        dictionary[kTPPairPair] = self.pair;
    }
    dictionary[kTPPairPairId] = @(self.pairId);
    dictionary[kTPPairRatio] = @(self.ratio);
    dictionary[kTPPairTokenId] = @(self.tokenId);
    if(self.tokenImage != nil){
        dictionary[kTPPairTokenImage] = self.tokenImage;
    }
    if(self.tokenName != nil){
        dictionary[kTPPairTokenName] = self.tokenName;
    }
    dictionary[kTPPairTransactionStatus] = @(self.transactionStatus);
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
    [aCoder encodeObject:@(self.increase) forKey:kTPPairIncrease];    if(self.pair != nil){
        [aCoder encodeObject:self.pair forKey:kTPPairPair];
    }
    [aCoder encodeObject:@(self.pairId) forKey:kTPPairPairId];    [aCoder encodeObject:@(self.ratio) forKey:kTPPairRatio];    [aCoder encodeObject:@(self.tokenId) forKey:kTPPairTokenId];    if(self.tokenImage != nil){
        [aCoder encodeObject:self.tokenImage forKey:kTPPairTokenImage];
    }
    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kTPPairTokenName];
    }
    [aCoder encodeObject:@(self.transactionStatus) forKey:kTPPairTransactionStatus];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.increase = [[aDecoder decodeObjectForKey:kTPPairIncrease] integerValue];
    self.pair = [aDecoder decodeObjectForKey:kTPPairPair];
    self.pairId = [[aDecoder decodeObjectForKey:kTPPairPairId] integerValue];
    self.ratio = [[aDecoder decodeObjectForKey:kTPPairRatio] integerValue];
    self.tokenId = [[aDecoder decodeObjectForKey:kTPPairTokenId] integerValue];
    self.tokenImage = [aDecoder decodeObjectForKey:kTPPairTokenImage];
    self.tokenName = [aDecoder decodeObjectForKey:kTPPairTokenName];
    self.transactionStatus = [[aDecoder decodeObjectForKey:kTPPairTransactionStatus] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    TPPair *copy = [TPPair new];
    
    copy.increase = self.increase;
    copy.pair = [self.pair copy];
    copy.pairId = self.pairId;
    copy.ratio = self.ratio;
    copy.tokenId = self.tokenId;
    copy.tokenImage = [self.tokenImage copy];
    copy.tokenName = [self.tokenName copy];
    copy.transactionStatus = self.transactionStatus;
    
    return copy;
}
@end
