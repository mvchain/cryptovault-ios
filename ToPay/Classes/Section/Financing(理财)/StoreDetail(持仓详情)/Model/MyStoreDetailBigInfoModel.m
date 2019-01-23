//
//    MyStoreDetailBigInfoModel.m
//
//    Create by 蒲公英 on 23/1/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MyStoreDetailBigInfoModel.h"

NSString *const kMyStoreDetailBigInfoModelBaseTokenName = @"baseTokenName";
NSString *const kMyStoreDetailBigInfoModelFinancialName = @"financialName";
NSString *const kMyStoreDetailBigInfoModelIncome = @"income";
NSString *const kMyStoreDetailBigInfoModelIncomeMax = @"incomeMax";
NSString *const kMyStoreDetailBigInfoModelIncomeMin = @"incomeMin";
NSString *const kMyStoreDetailBigInfoModelTimes = @"times";
NSString *const kMyStoreDetailBigInfoModelTokenName = @"tokenName";
NSString *const kMyStoreDetailBigInfoModelValue = @"value";

@interface MyStoreDetailBigInfoModel ()
@end
@implementation MyStoreDetailBigInfoModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kMyStoreDetailBigInfoModelBaseTokenName] isKindOfClass:[NSNull class]]){
        self.baseTokenName = dictionary[kMyStoreDetailBigInfoModelBaseTokenName];
    }
    if(![dictionary[kMyStoreDetailBigInfoModelFinancialName] isKindOfClass:[NSNull class]]){
        self.financialName = dictionary[kMyStoreDetailBigInfoModelFinancialName];
    }
    if(![dictionary[kMyStoreDetailBigInfoModelIncome] isKindOfClass:[NSNull class]]){
        self.income = [dictionary[kMyStoreDetailBigInfoModelIncome] floatValue];
    }
    
    if(![dictionary[kMyStoreDetailBigInfoModelIncomeMax] isKindOfClass:[NSNull class]]){
        self.incomeMax = [dictionary[kMyStoreDetailBigInfoModelIncomeMax] floatValue];
    }
    
    if(![dictionary[kMyStoreDetailBigInfoModelIncomeMin] isKindOfClass:[NSNull class]]){
        self.incomeMin = [dictionary[kMyStoreDetailBigInfoModelIncomeMin] floatValue];
    }
    
    if(![dictionary[kMyStoreDetailBigInfoModelTimes] isKindOfClass:[NSNull class]]){
        self.times = [dictionary[kMyStoreDetailBigInfoModelTimes] integerValue];
    }
    
    if(![dictionary[kMyStoreDetailBigInfoModelTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kMyStoreDetailBigInfoModelTokenName];
    }
    if(![dictionary[kMyStoreDetailBigInfoModelValue] isKindOfClass:[NSNull class]]){
        self.value = [dictionary[kMyStoreDetailBigInfoModelValue] floatValue];
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
        dictionary[kMyStoreDetailBigInfoModelBaseTokenName] = self.baseTokenName;
    }
    if(self.financialName != nil){
        dictionary[kMyStoreDetailBigInfoModelFinancialName] = self.financialName;
    }
    dictionary[kMyStoreDetailBigInfoModelIncome] = @(self.income);
    dictionary[kMyStoreDetailBigInfoModelIncomeMax] = @(self.incomeMax);
    dictionary[kMyStoreDetailBigInfoModelIncomeMin] = @(self.incomeMin);
    dictionary[kMyStoreDetailBigInfoModelTimes] = @(self.times);
    if(self.tokenName != nil){
        dictionary[kMyStoreDetailBigInfoModelTokenName] = self.tokenName;
    }
    dictionary[kMyStoreDetailBigInfoModelValue] = @(self.value);
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
        [aCoder encodeObject:self.baseTokenName forKey:kMyStoreDetailBigInfoModelBaseTokenName];
    }
    if(self.financialName != nil){
        [aCoder encodeObject:self.financialName forKey:kMyStoreDetailBigInfoModelFinancialName];
    }
    [aCoder encodeObject:@(self.income) forKey:kMyStoreDetailBigInfoModelIncome];    [aCoder encodeObject:@(self.incomeMax) forKey:kMyStoreDetailBigInfoModelIncomeMax];    [aCoder encodeObject:@(self.incomeMin) forKey:kMyStoreDetailBigInfoModelIncomeMin];    [aCoder encodeObject:@(self.times) forKey:kMyStoreDetailBigInfoModelTimes];    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kMyStoreDetailBigInfoModelTokenName];
    }
    [aCoder encodeObject:@(self.value) forKey:kMyStoreDetailBigInfoModelValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.baseTokenName = [aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelBaseTokenName];
    self.financialName = [aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelFinancialName];
    self.income = [[aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelIncome] floatValue];
    self.incomeMax = [[aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelIncomeMax] floatValue];
    self.incomeMin = [[aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelIncomeMin] floatValue];
    self.times = [[aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelTimes] integerValue];
    self.tokenName = [aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelTokenName];
    self.value = [[aDecoder decodeObjectForKey:kMyStoreDetailBigInfoModelValue] floatValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    MyStoreDetailBigInfoModel *copy = [MyStoreDetailBigInfoModel new];
    
    copy.baseTokenName = [self.baseTokenName copy];
    copy.financialName = [self.financialName copy];
    copy.income = self.income;
    copy.incomeMax = self.incomeMax;
    copy.incomeMin = self.incomeMin;
    copy.times = self.times;
    copy.tokenName = [self.tokenName copy];
    copy.value = self.value;
    
    return copy;
}
@end
