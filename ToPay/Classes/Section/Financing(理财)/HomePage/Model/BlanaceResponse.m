//
//	BlanaceResponse.m
//
//	Create by 蒲公英 on 22/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlanaceResponse.h"

NSString *const kBlanaceResponseBalance = @"balance";
NSString *const kBlanaceResponseIncome = @"income";
NSString *const kBlanaceResponseLastIncome = @"lastIncome";

@interface BlanaceResponse ()
@end
@implementation BlanaceResponse




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBlanaceResponseBalance] isKindOfClass:[NSNull class]]){
		self.balance = [dictionary[kBlanaceResponseBalance] floatValue];
	}

	if(![dictionary[kBlanaceResponseIncome] isKindOfClass:[NSNull class]]){
        self.income = [dictionary[kBlanaceResponseIncome] floatValue];
	}

	if(![dictionary[kBlanaceResponseLastIncome] isKindOfClass:[NSNull class]]){
		self.lastIncome = [dictionary[kBlanaceResponseLastIncome] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kBlanaceResponseBalance] = @(self.balance);
	dictionary[kBlanaceResponseIncome] = @(self.income);
	dictionary[kBlanaceResponseLastIncome] = @(self.lastIncome);
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
	[aCoder encodeObject:@(self.balance) forKey:kBlanaceResponseBalance];	[aCoder encodeObject:@(self.income) forKey:kBlanaceResponseIncome];	[aCoder encodeObject:@(self.lastIncome) forKey:kBlanaceResponseLastIncome];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.balance = [[aDecoder decodeObjectForKey:kBlanaceResponseBalance] floatValue];
	self.income = [[aDecoder decodeObjectForKey:kBlanaceResponseIncome] floatValue];
	self.lastIncome = [[aDecoder decodeObjectForKey:kBlanaceResponseLastIncome] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BlanaceResponse *copy = [BlanaceResponse new];

	copy.balance = self.balance;
	copy.income = self.income;
	copy.lastIncome = self.lastIncome;

	return copy;
}
@end
