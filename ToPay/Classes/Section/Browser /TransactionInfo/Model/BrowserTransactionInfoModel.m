//
//    BrowserTransactionInfoModel.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BrowserTransactionInfoModel.h"

NSString *const kBrowserTransactionInfoModelConfirm = @"confirm";
NSString *const kBrowserTransactionInfoModelCreatedAt = @"createdAt";
NSString *const kBrowserTransactionInfoModelFrom = @"from";
NSString *const kBrowserTransactionInfoModelHash = @"hash";
NSString *const kBrowserTransactionInfoModelHeight = @"height";
NSString *const kBrowserTransactionInfoModelTo = @"to";
NSString *const kBrowserTransactionInfoModelTokenName = @"tokenName";
NSString *const kBrowserTransactionInfoModelValue = @"value";

@interface BrowserTransactionInfoModel ()
@end
@implementation BrowserTransactionInfoModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBrowserTransactionInfoModelConfirm] isKindOfClass:[NSNull class]]){
        self.confirm = [dictionary[kBrowserTransactionInfoModelConfirm] integerValue];
    }
    
    if(![dictionary[kBrowserTransactionInfoModelCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kBrowserTransactionInfoModelCreatedAt] integerValue];
    }
    
    if(![dictionary[kBrowserTransactionInfoModelFrom] isKindOfClass:[NSNull class]]){
        self.from = dictionary[kBrowserTransactionInfoModelFrom];
    }
    if(![dictionary[kBrowserTransactionInfoModelHash] isKindOfClass:[NSNull class]]){
        self.yhash = dictionary[kBrowserTransactionInfoModelHash];
    }
    if(![dictionary[kBrowserTransactionInfoModelHeight] isKindOfClass:[NSNull class]]){
        self.height = [dictionary[kBrowserTransactionInfoModelHeight] integerValue];
    }
    
    if(![dictionary[kBrowserTransactionInfoModelTo] isKindOfClass:[NSNull class]]){
        self.to = dictionary[kBrowserTransactionInfoModelTo];
    }
    if(![dictionary[kBrowserTransactionInfoModelTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kBrowserTransactionInfoModelTokenName];
    }
    if(![dictionary[kBrowserTransactionInfoModelValue] isKindOfClass:[NSNull class]]){
        self.value = [dictionary[kBrowserTransactionInfoModelValue] doubleValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBrowserTransactionInfoModelConfirm] = @(self.confirm);
    dictionary[kBrowserTransactionInfoModelCreatedAt] = @(self.createdAt);
    if(self.from != nil){
        dictionary[kBrowserTransactionInfoModelFrom] = self.from;
    }
    if(self.yhash != nil){
        dictionary[kBrowserTransactionInfoModelHash] = self.yhash;
    }
    dictionary[kBrowserTransactionInfoModelHeight] = @(self.height);
    if(self.to != nil){
        dictionary[kBrowserTransactionInfoModelTo] = self.to;
    }
    if(self.tokenName != nil){
        dictionary[kBrowserTransactionInfoModelTokenName] = self.tokenName;
    }
    dictionary[kBrowserTransactionInfoModelValue] = @(self.value);
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
    [aCoder encodeObject:@(self.confirm) forKey:kBrowserTransactionInfoModelConfirm];    [aCoder encodeObject:@(self.createdAt) forKey:kBrowserTransactionInfoModelCreatedAt];    if(self.from != nil){
        [aCoder encodeObject:self.from forKey:kBrowserTransactionInfoModelFrom];
    }
    if(self.yhash != nil){
        [aCoder encodeObject:self.yhash forKey:kBrowserTransactionInfoModelHash];
    }
    [aCoder encodeObject:@(self.height) forKey:kBrowserTransactionInfoModelHeight];    if(self.to != nil){
        [aCoder encodeObject:self.to forKey:kBrowserTransactionInfoModelTo];
    }
    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kBrowserTransactionInfoModelTokenName];
    }
    [aCoder encodeObject:@(self.value) forKey:kBrowserTransactionInfoModelValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.confirm = [[aDecoder decodeObjectForKey:kBrowserTransactionInfoModelConfirm] integerValue];
    self.createdAt = [[aDecoder decodeObjectForKey:kBrowserTransactionInfoModelCreatedAt] integerValue];
    self.from = [aDecoder decodeObjectForKey:kBrowserTransactionInfoModelFrom];
    self.yhash = [aDecoder decodeObjectForKey:kBrowserTransactionInfoModelHash];
    self.height = [[aDecoder decodeObjectForKey:kBrowserTransactionInfoModelHeight] integerValue];
    self.to = [aDecoder decodeObjectForKey:kBrowserTransactionInfoModelTo];
    self.tokenName = [aDecoder decodeObjectForKey:kBrowserTransactionInfoModelTokenName];
    self.value = [[aDecoder decodeObjectForKey:kBrowserTransactionInfoModelValue] doubleValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BrowserTransactionInfoModel *copy = [BrowserTransactionInfoModel new];
    
    copy.confirm = self.confirm;
    copy.createdAt = self.createdAt;
    copy.from = [self.from copy];
    copy.yhash = [self.yhash copy];
    copy.height = self.height;
    copy.to = [self.to copy];
    copy.tokenName = [self.tokenName copy];
    copy.value = self.value;
    
    return copy;
}
@end
