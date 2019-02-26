//
//    FinProductDetailModel.m
//
//    Create by 蒲公英 on 22/1/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FinProductDetailModel.h"

NSString *const kFinProductDetailModelBalance = @"balance";
NSString *const kFinProductDetailModelBaseTokenId = @"baseTokenId";
NSString *const kFinProductDetailModelBaseTokenName = @"baseTokenName";
NSString *const kFinProductDetailModelContent = @"content";
NSString *const kFinProductDetailModelIdField = @"id";
NSString *const kFinProductDetailModelIncomeMax = @"incomeMax";
NSString *const kFinProductDetailModelIncomeMin = @"incomeMin";
NSString *const kFinProductDetailModelLimitValue = @"limitValue";
NSString *const kFinProductDetailModelMinValue = @"minValue";
NSString *const kFinProductDetailModelName = @"name";
NSString *const kFinProductDetailModelPurchased = @"purchased";
NSString *const kFinProductDetailModelRatio = @"ratio";
NSString *const kFinProductDetailModelRule = @"rule";
NSString *const kFinProductDetailModelStartAt = @"startAt";
NSString *const kFinProductDetailModelStopAt = @"stopAt";
NSString *const kFinProductDetailModelTimes = @"times";
NSString *const kFinProductDetailModelTokenId = @"tokenId";
NSString *const kFinProductDetailModelTokenName = @"tokenName";
NSString *const kFinProductDetailModelUserLimit = @"userLimit";

@interface FinProductDetailModel ()
@end
@implementation FinProductDetailModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kFinProductDetailModelBalance] isKindOfClass:[NSNull class]]){
        self.balance = [dictionary[kFinProductDetailModelBalance] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelBaseTokenId] isKindOfClass:[NSNull class]]){
        self.baseTokenId = [dictionary[kFinProductDetailModelBaseTokenId] integerValue];
    }
    
    if(![dictionary[kFinProductDetailModelBaseTokenName] isKindOfClass:[NSNull class]]){
        self.baseTokenName = dictionary[kFinProductDetailModelBaseTokenName];
    }
    if(![dictionary[kFinProductDetailModelContent] isKindOfClass:[NSNull class]]){
        self.content = dictionary[kFinProductDetailModelContent];
    }
    if(![dictionary[kFinProductDetailModelIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kFinProductDetailModelIdField] integerValue];
    }
    
    if(![dictionary[kFinProductDetailModelIncomeMax] isKindOfClass:[NSNull class]]){
        self.incomeMax = [dictionary[kFinProductDetailModelIncomeMax] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelIncomeMin] isKindOfClass:[NSNull class]]){
        self.incomeMin = [dictionary[kFinProductDetailModelIncomeMin] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelLimitValue] isKindOfClass:[NSNull class]]){
        self.limitValue = [dictionary[kFinProductDetailModelLimitValue] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelMinValue] isKindOfClass:[NSNull class]]){
        self.minValue = [dictionary[kFinProductDetailModelMinValue] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kFinProductDetailModelName];
    }
    if(![dictionary[kFinProductDetailModelPurchased] isKindOfClass:[NSNull class]]){
        self.purchased = [dictionary[kFinProductDetailModelPurchased] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelRatio] isKindOfClass:[NSNull class]]){
        self.ratio = [dictionary[kFinProductDetailModelRatio] floatValue];
    }
    
    if(![dictionary[kFinProductDetailModelRule] isKindOfClass:[NSNull class]]){
        self.rule = dictionary[kFinProductDetailModelRule];
    }
    if(![dictionary[kFinProductDetailModelStartAt] isKindOfClass:[NSNull class]]){
        self.startAt = [dictionary[kFinProductDetailModelStartAt] integerValue];
    }
    
    if(![dictionary[kFinProductDetailModelStopAt] isKindOfClass:[NSNull class]]){
        self.stopAt = [dictionary[kFinProductDetailModelStopAt] integerValue];
    }
    
    if(![dictionary[kFinProductDetailModelTimes] isKindOfClass:[NSNull class]]){
        self.times = [dictionary[kFinProductDetailModelTimes] integerValue];
    }
    
    if(![dictionary[kFinProductDetailModelTokenId] isKindOfClass:[NSNull class]]){
        self.tokenId = [dictionary[kFinProductDetailModelTokenId] integerValue];
    }
    
    if(![dictionary[kFinProductDetailModelTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kFinProductDetailModelTokenName];
    }
    if(![dictionary[kFinProductDetailModelUserLimit] isKindOfClass:[NSNull class]]){
        self.userLimit = [dictionary[kFinProductDetailModelUserLimit] doubleValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kFinProductDetailModelBalance] = @(self.balance);
    dictionary[kFinProductDetailModelBaseTokenId] = @(self.baseTokenId);
    if(self.baseTokenName != nil){
        dictionary[kFinProductDetailModelBaseTokenName] = self.baseTokenName;
    }
    if(self.content != nil){
        dictionary[kFinProductDetailModelContent] = self.content;
    }
    dictionary[kFinProductDetailModelIdField] = @(self.idField);
    dictionary[kFinProductDetailModelIncomeMax] = @(self.incomeMax);
    dictionary[kFinProductDetailModelIncomeMin] = @(self.incomeMin);
    dictionary[kFinProductDetailModelLimitValue] = @(self.limitValue);
    dictionary[kFinProductDetailModelMinValue] = @(self.minValue);
    if(self.name != nil){
        dictionary[kFinProductDetailModelName] = self.name;
    }
    dictionary[kFinProductDetailModelPurchased] = @(self.purchased);
    dictionary[kFinProductDetailModelRatio] = @(self.ratio);
    if(self.rule != nil){
        dictionary[kFinProductDetailModelRule] = self.rule;
    }
    dictionary[kFinProductDetailModelStartAt] = @(self.startAt);
    dictionary[kFinProductDetailModelStopAt] = @(self.stopAt);
    dictionary[kFinProductDetailModelTimes] = @(self.times);
    dictionary[kFinProductDetailModelTokenId] = @(self.tokenId);
    if(self.tokenName != nil){
        dictionary[kFinProductDetailModelTokenName] = self.tokenName;
    }
    dictionary[kFinProductDetailModelUserLimit] = @(self.userLimit);
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
    [aCoder encodeObject:@(self.balance) forKey:kFinProductDetailModelBalance];    [aCoder encodeObject:@(self.baseTokenId) forKey:kFinProductDetailModelBaseTokenId];    if(self.baseTokenName != nil){
        [aCoder encodeObject:self.baseTokenName forKey:kFinProductDetailModelBaseTokenName];
    }
    if(self.content != nil){
        [aCoder encodeObject:self.content forKey:kFinProductDetailModelContent];
    }
    [aCoder encodeObject:@(self.idField) forKey:kFinProductDetailModelIdField];    [aCoder encodeObject:@(self.incomeMax) forKey:kFinProductDetailModelIncomeMax];    [aCoder encodeObject:@(self.incomeMin) forKey:kFinProductDetailModelIncomeMin];    [aCoder encodeObject:@(self.limitValue) forKey:kFinProductDetailModelLimitValue];    [aCoder encodeObject:@(self.minValue) forKey:kFinProductDetailModelMinValue];    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kFinProductDetailModelName];
    }
    [aCoder encodeObject:@(self.purchased) forKey:kFinProductDetailModelPurchased];    [aCoder encodeObject:@(self.ratio) forKey:kFinProductDetailModelRatio];    if(self.rule != nil){
        [aCoder encodeObject:self.rule forKey:kFinProductDetailModelRule];
    }
    [aCoder encodeObject:@(self.startAt) forKey:kFinProductDetailModelStartAt];    [aCoder encodeObject:@(self.stopAt) forKey:kFinProductDetailModelStopAt];    [aCoder encodeObject:@(self.times) forKey:kFinProductDetailModelTimes];    [aCoder encodeObject:@(self.tokenId) forKey:kFinProductDetailModelTokenId];    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kFinProductDetailModelTokenName];
    }
    [aCoder encodeObject:@(self.userLimit) forKey:kFinProductDetailModelUserLimit];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.balance = [[aDecoder decodeObjectForKey:kFinProductDetailModelBalance] floatValue];
    self.baseTokenId = [[aDecoder decodeObjectForKey:kFinProductDetailModelBaseTokenId] integerValue];
    self.baseTokenName = [aDecoder decodeObjectForKey:kFinProductDetailModelBaseTokenName];
    self.content = [aDecoder decodeObjectForKey:kFinProductDetailModelContent];
    self.idField = [[aDecoder decodeObjectForKey:kFinProductDetailModelIdField] integerValue];
    self.incomeMax = [[aDecoder decodeObjectForKey:kFinProductDetailModelIncomeMax] floatValue];
    self.incomeMin = [[aDecoder decodeObjectForKey:kFinProductDetailModelIncomeMin] floatValue];
    self.limitValue = [[aDecoder decodeObjectForKey:kFinProductDetailModelLimitValue] floatValue];
    self.minValue = [[aDecoder decodeObjectForKey:kFinProductDetailModelMinValue] floatValue];
    self.name = [aDecoder decodeObjectForKey:kFinProductDetailModelName];
    self.purchased = [[aDecoder decodeObjectForKey:kFinProductDetailModelPurchased] floatValue];
    self.ratio = [[aDecoder decodeObjectForKey:kFinProductDetailModelRatio] floatValue];
    self.rule = [aDecoder decodeObjectForKey:kFinProductDetailModelRule];
    self.startAt = [[aDecoder decodeObjectForKey:kFinProductDetailModelStartAt] integerValue];
    self.stopAt = [[aDecoder decodeObjectForKey:kFinProductDetailModelStopAt] integerValue];
    self.times = [[aDecoder decodeObjectForKey:kFinProductDetailModelTimes] integerValue];
    self.tokenId = [[aDecoder decodeObjectForKey:kFinProductDetailModelTokenId] integerValue];
    self.tokenName = [aDecoder decodeObjectForKey:kFinProductDetailModelTokenName];
    self.userLimit = [[aDecoder decodeObjectForKey:kFinProductDetailModelUserLimit] doubleValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    FinProductDetailModel *copy = [FinProductDetailModel new];
    
    copy.balance = self.balance;
    copy.baseTokenId = self.baseTokenId;
    copy.baseTokenName = [self.baseTokenName copy];
    copy.content = [self.content copy];
    copy.idField = self.idField;
    copy.incomeMax = self.incomeMax;
    copy.incomeMin = self.incomeMin;
    copy.limitValue = self.limitValue;
    copy.minValue = self.minValue;
    copy.name = [self.name copy];
    copy.purchased = self.purchased;
    copy.ratio = self.ratio;
    copy.rule = [self.rule copy];
    copy.startAt = self.startAt;
    copy.stopAt = self.stopAt;
    copy.times = self.times;
    copy.tokenId = self.tokenId;
    copy.tokenName = [self.tokenName copy];
    copy.userLimit = self.userLimit;
    
    return copy;
}
@end
