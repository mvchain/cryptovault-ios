//
//	MyEveryDayIncomItemModel.m
//
//	Create by 蒲公英 on 23/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MyEveryDayIncomItemModel.h"

NSString *const kMyEveryDayIncomItemModelCreatedAt = @"createdAt";
NSString *const kMyEveryDayIncomItemModelIdField = @"id";
NSString *const kMyEveryDayIncomItemModelIncome = @"income";
NSString *const kMyEveryDayIncomItemModelTokenName = @"tokenName";

@interface MyEveryDayIncomItemModel ()
@end
@implementation MyEveryDayIncomItemModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMyEveryDayIncomItemModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = [dictionary[kMyEveryDayIncomItemModelCreatedAt] integerValue];
	}

	if(![dictionary[kMyEveryDayIncomItemModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMyEveryDayIncomItemModelIdField] integerValue];
	}

	if(![dictionary[kMyEveryDayIncomItemModelIncome] isKindOfClass:[NSNull class]]){
		self.income = [dictionary[kMyEveryDayIncomItemModelIncome] floatValue];
	}

	if(![dictionary[kMyEveryDayIncomItemModelTokenName] isKindOfClass:[NSNull class]]){
		self.tokenName = dictionary[kMyEveryDayIncomItemModelTokenName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMyEveryDayIncomItemModelCreatedAt] = @(self.createdAt);
	dictionary[kMyEveryDayIncomItemModelIdField] = @(self.idField);
	dictionary[kMyEveryDayIncomItemModelIncome] = @(self.income);
	if(self.tokenName != nil){
		dictionary[kMyEveryDayIncomItemModelTokenName] = self.tokenName;
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
	[aCoder encodeObject:@(self.createdAt) forKey:kMyEveryDayIncomItemModelCreatedAt];	[aCoder encodeObject:@(self.idField) forKey:kMyEveryDayIncomItemModelIdField];	[aCoder encodeObject:@(self.income) forKey:kMyEveryDayIncomItemModelIncome];	if(self.tokenName != nil){
		[aCoder encodeObject:self.tokenName forKey:kMyEveryDayIncomItemModelTokenName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.createdAt = [[aDecoder decodeObjectForKey:kMyEveryDayIncomItemModelCreatedAt] integerValue];
	self.idField = [[aDecoder decodeObjectForKey:kMyEveryDayIncomItemModelIdField] integerValue];
	self.income = [[aDecoder decodeObjectForKey:kMyEveryDayIncomItemModelIncome] floatValue];
	self.tokenName = [aDecoder decodeObjectForKey:kMyEveryDayIncomItemModelTokenName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MyEveryDayIncomItemModel *copy = [MyEveryDayIncomItemModel new];

	copy.createdAt = self.createdAt;
	copy.idField = self.idField;
	copy.income = self.income;
	copy.tokenName = [self.tokenName copy];

	return copy;
}
@end