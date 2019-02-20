//
//	M_ReleaseProjectRecordItem.m
//
//	Create by 蒲公英 on 18/2/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ReleaseProjectRecordItem.h"

NSString *const kM_ReleaseProjectRecordItemCreatedAt = @"createdAt";
NSString *const kM_ReleaseProjectRecordItemIdField = @"id";
NSString *const kM_ReleaseProjectRecordItemTokenId = @"tokenId";
NSString *const kM_ReleaseProjectRecordItemTokenName = @"tokenName";
NSString *const kM_ReleaseProjectRecordItemValue = @"value";

@interface M_ReleaseProjectRecordItem ()
@end
@implementation M_ReleaseProjectRecordItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ReleaseProjectRecordItemCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = [dictionary[kM_ReleaseProjectRecordItemCreatedAt] integerValue];
	}

	if(![dictionary[kM_ReleaseProjectRecordItemIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kM_ReleaseProjectRecordItemIdField] integerValue];
	}

	if(![dictionary[kM_ReleaseProjectRecordItemTokenId] isKindOfClass:[NSNull class]]){
		self.tokenId = [dictionary[kM_ReleaseProjectRecordItemTokenId] integerValue];
	}

	if(![dictionary[kM_ReleaseProjectRecordItemTokenName] isKindOfClass:[NSNull class]]){
		self.tokenName = dictionary[kM_ReleaseProjectRecordItemTokenName];
	}	
	if(![dictionary[kM_ReleaseProjectRecordItemValue] isKindOfClass:[NSNull class]]){
		self.value = [dictionary[kM_ReleaseProjectRecordItemValue] doubleValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_ReleaseProjectRecordItemCreatedAt] = @(self.createdAt);
	dictionary[kM_ReleaseProjectRecordItemIdField] = @(self.idField);
	dictionary[kM_ReleaseProjectRecordItemTokenId] = @(self.tokenId);
	if(self.tokenName != nil){
		dictionary[kM_ReleaseProjectRecordItemTokenName] = self.tokenName;
	}
	dictionary[kM_ReleaseProjectRecordItemValue] = @(self.value);
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
	[aCoder encodeObject:@(self.createdAt) forKey:kM_ReleaseProjectRecordItemCreatedAt];	[aCoder encodeObject:@(self.idField) forKey:kM_ReleaseProjectRecordItemIdField];	[aCoder encodeObject:@(self.tokenId) forKey:kM_ReleaseProjectRecordItemTokenId];	if(self.tokenName != nil){
		[aCoder encodeObject:self.tokenName forKey:kM_ReleaseProjectRecordItemTokenName];
	}
	[aCoder encodeObject:@(self.value) forKey:kM_ReleaseProjectRecordItemValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.createdAt = [[aDecoder decodeObjectForKey:kM_ReleaseProjectRecordItemCreatedAt] integerValue];
	self.idField = [[aDecoder decodeObjectForKey:kM_ReleaseProjectRecordItemIdField] integerValue];
	self.tokenId = [[aDecoder decodeObjectForKey:kM_ReleaseProjectRecordItemTokenId] integerValue];
	self.tokenName = [aDecoder decodeObjectForKey:kM_ReleaseProjectRecordItemTokenName];
	self.value = [[aDecoder decodeObjectForKey:kM_ReleaseProjectRecordItemValue] doubleValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ReleaseProjectRecordItem *copy = [M_ReleaseProjectRecordItem new];

	copy.createdAt = self.createdAt;
	copy.idField = self.idField;
	copy.tokenId = self.tokenId;
	copy.tokenName = [self.tokenName copy];
	copy.value = self.value;

	return copy;
}
@end
