//
//	FinancialProductModel.m
//
//	Create by 蒲公英 on 22/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FinancialProductModel.h"

NSString *const kFinancialProductModelBaseTokenName = @"baseTokenName";
NSString *const kFinancialProductModelIdField = @"id";
NSString *const kFinancialProductModelIncomeMax = @"incomeMax";
NSString *const kFinancialProductModelIncomeMin = @"incomeMin";
NSString *const kFinancialProductModelMinValue = @"minValue";
NSString *const kFinancialProductModelName = @"name";
NSString *const kFinancialProductModelStopAt = @"stopAt";
NSString *const kFinancialProductModelTimes = @"times";

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
		self.incomeMax = [dictionary[kFinancialProductModelIncomeMax] floatValue];
	}

	if(![dictionary[kFinancialProductModelIncomeMin] isKindOfClass:[NSNull class]]){
		self.incomeMin = [dictionary[kFinancialProductModelIncomeMin] floatValue];
	}

	if(![dictionary[kFinancialProductModelMinValue] isKindOfClass:[NSNull class]]){
		self.minValue = [dictionary[kFinancialProductModelMinValue] floatValue];
	}

	if(![dictionary[kFinancialProductModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kFinancialProductModelName];
	}	
	if(![dictionary[kFinancialProductModelStopAt] isKindOfClass:[NSNull class]]){
		self.stopAt = [dictionary[kFinancialProductModelStopAt] integerValue];
	}

	if(![dictionary[kFinancialProductModelTimes] isKindOfClass:[NSNull class]]){
		self.times = [dictionary[kFinancialProductModelTimes] integerValue];
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
	dictionary[kFinancialProductModelMinValue] = @(self.minValue);
	if(self.name != nil){
		dictionary[kFinancialProductModelName] = self.name;
	}
	dictionary[kFinancialProductModelStopAt] = @(self.stopAt);
	dictionary[kFinancialProductModelTimes] = @(self.times);
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
	[aCoder encodeObject:@(self.idField) forKey:kFinancialProductModelIdField];	[aCoder encodeObject:@(self.incomeMax) forKey:kFinancialProductModelIncomeMax];	[aCoder encodeObject:@(self.incomeMin) forKey:kFinancialProductModelIncomeMin];	[aCoder encodeObject:@(self.minValue) forKey:kFinancialProductModelMinValue];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kFinancialProductModelName];
	}
	[aCoder encodeObject:@(self.stopAt) forKey:kFinancialProductModelStopAt];	[aCoder encodeObject:@(self.times) forKey:kFinancialProductModelTimes];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.baseTokenName = [aDecoder decodeObjectForKey:kFinancialProductModelBaseTokenName];
	self.idField = [[aDecoder decodeObjectForKey:kFinancialProductModelIdField] integerValue];
	self.incomeMax = [[aDecoder decodeObjectForKey:kFinancialProductModelIncomeMax] floatValue];
	self.incomeMin = [[aDecoder decodeObjectForKey:kFinancialProductModelIncomeMin] floatValue];
	self.minValue = [[aDecoder decodeObjectForKey:kFinancialProductModelMinValue] floatValue];
	self.name = [aDecoder decodeObjectForKey:kFinancialProductModelName];
	self.stopAt = [[aDecoder decodeObjectForKey:kFinancialProductModelStopAt] integerValue];
	self.times = [[aDecoder decodeObjectForKey:kFinancialProductModelTimes] integerValue];
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
	copy.minValue = self.minValue;
	copy.name = [self.name copy];
	copy.stopAt = self.stopAt;
	copy.times = self.times;

	return copy;
}
@end