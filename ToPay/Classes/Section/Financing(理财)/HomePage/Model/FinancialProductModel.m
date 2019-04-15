//
//    FinancialProductModel.m
//
//    Create by 蒲公英 on 10/4/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FinancialProductModel.h"

NSString *const kFinancialProductModelBaseTokenName = @"baseTokenName";
NSString *const kFinancialProductModelIdField = @"id";
NSString *const kFinancialProductModelIncomeMax = @"incomeMax";
NSString *const kFinancialProductModelIncomeMin = @"incomeMin";
NSString *const kFinancialProductModelLimitValue = @"limitValue";
NSString *const kFinancialProductModelMinValue = @"minValue";
NSString *const kFinancialProductModelName = @"name";
NSString *const kFinancialProductModelSold = @"sold";
NSString *const kFinancialProductModelStopAt = @"stopAt";
NSString *const kFinancialProductModelTimes = @"times";
NSString *const kFinancialProductModelNeedSign = @"needSign";
@interface FinancialProductModel ()
@end
@implementation FinancialProductModel



/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kFinancialProductModelBaseTokenName] isKindOfClass:[NSNull class]]){
        self.baseTokenName = dictionary[kFinancialProductModelBaseTokenName];
    }
    if(![dictionary[kFinancialProductModelIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kFinancialProductModelIdField] integerValue];
    }
    
    if(![dictionary[kFinancialProductModelIncomeMax] isKindOfClass:[NSNull class]]){
        self.incomeMax = [dictionary[kFinancialProductModelIncomeMax] doubleValue];
    }
    
    if(![dictionary[kFinancialProductModelIncomeMin] isKindOfClass:[NSNull class]]){
        self.incomeMin = [dictionary[kFinancialProductModelIncomeMin] doubleValue];
    }
    
    if(![dictionary[kFinancialProductModelLimitValue] isKindOfClass:[NSNull class]]){
        self.limitValue = [dictionary[kFinancialProductModelLimitValue] doubleValue];
    }
    
    if(![dictionary[kFinancialProductModelMinValue] isKindOfClass:[NSNull class]]){
        self.minValue = [dictionary[kFinancialProductModelMinValue] doubleValue];
    }
    
    if(![dictionary[kFinancialProductModelName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kFinancialProductModelName];
    }
    if(![dictionary[kFinancialProductModelSold] isKindOfClass:[NSNull class]]){
        self.sold = [dictionary[kFinancialProductModelSold] doubleValue];
    }
    
    if(![dictionary[kFinancialProductModelStopAt] isKindOfClass:[NSNull class]]){
        self.stopAt = [dictionary[kFinancialProductModelStopAt] integerValue];
    }
    
    if(![dictionary[kFinancialProductModelTimes] isKindOfClass:[NSNull class]]){
        self.times = [dictionary[kFinancialProductModelTimes] integerValue];
    }
    if(![dictionary[kFinancialProductModelNeedSign] isKindOfClass:[NSNull class]]){
        self.needSign = [dictionary[kFinancialProductModelNeedSign] integerValue];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.baseTokenName != nil){
        dictionary[kFinancialProductModelBaseTokenName] = self.baseTokenName;
    }
    dictionary[kFinancialProductModelIdField] = @(self.idField);
    dictionary[kFinancialProductModelIncomeMax] = @(self.incomeMax);
    dictionary[kFinancialProductModelIncomeMin] = @(self.incomeMin);
    dictionary[kFinancialProductModelLimitValue] = @(self.limitValue);
    dictionary[kFinancialProductModelMinValue] = @(self.minValue);
    if(self.name != nil){
        dictionary[kFinancialProductModelName] = self.name;
    }
    dictionary[kFinancialProductModelSold] = @(self.sold);
    dictionary[kFinancialProductModelStopAt] = @(self.stopAt);
    dictionary[kFinancialProductModelTimes] = @(self.times);
    dictionary[kFinancialProductModelNeedSign] = @(self.needSign);
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
    if(self.baseTokenName != nil){
        [aCoder encodeObject:self.baseTokenName forKey:kFinancialProductModelBaseTokenName];
    }
    [aCoder encodeObject:@(self.idField) forKey:kFinancialProductModelIdField];    [aCoder encodeObject:@(self.incomeMax) forKey:kFinancialProductModelIncomeMax];    [aCoder encodeObject:@(self.incomeMin) forKey:kFinancialProductModelIncomeMin];    [aCoder encodeObject:@(self.limitValue) forKey:kFinancialProductModelLimitValue];    [aCoder encodeObject:@(self.minValue) forKey:kFinancialProductModelMinValue];    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kFinancialProductModelName];
    }
    [aCoder encodeObject:@(self.sold) forKey:kFinancialProductModelSold];    [aCoder encodeObject:@(self.stopAt) forKey:kFinancialProductModelStopAt];    [aCoder encodeObject:@(self.times) forKey:kFinancialProductModelTimes];
    [aCoder encodeObject:@(self.needSign) forKey:kFinancialProductModelNeedSign];
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.baseTokenName = [aDecoder decodeObjectForKey:kFinancialProductModelBaseTokenName];
    self.idField = [[aDecoder decodeObjectForKey:kFinancialProductModelIdField] integerValue];
    self.incomeMax = [[aDecoder decodeObjectForKey:kFinancialProductModelIncomeMax] doubleValue];
    self.incomeMin = [[aDecoder decodeObjectForKey:kFinancialProductModelIncomeMin] doubleValue];
    self.limitValue = [[aDecoder decodeObjectForKey:kFinancialProductModelLimitValue] doubleValue];
    self.minValue = [[aDecoder decodeObjectForKey:kFinancialProductModelMinValue] doubleValue];
    self.name = [aDecoder decodeObjectForKey:kFinancialProductModelName];
    self.sold = [[aDecoder decodeObjectForKey:kFinancialProductModelSold] doubleValue];
    self.stopAt = [[aDecoder decodeObjectForKey:kFinancialProductModelStopAt] integerValue];
    self.times = [[aDecoder decodeObjectForKey:kFinancialProductModelTimes] integerValue];
    self.needSign = [[aDecoder decodeObjectForKey:kFinancialProductModelNeedSign] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    FinancialProductModel *copy = [FinancialProductModel new];
    
    copy.baseTokenName = [self.baseTokenName copy];
    copy.idField = self.idField;
    copy.incomeMax = self.incomeMax;
    copy.incomeMin = self.incomeMin;
    copy.limitValue = self.limitValue;
    copy.minValue = self.minValue;
    copy.name = [self.name copy];
    copy.sold = self.sold;
    copy.stopAt = self.stopAt;
    copy.times = self.times;
    
    return copy;
}
@end
