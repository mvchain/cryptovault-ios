//
//	TPRecommendedUserModel.m
//
//	Create by 蒲公英 on 21/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TPRecommendedUserModel.h"

NSString *const kTPRecommendedUserModelCreatedAt = @"createdAt";
NSString *const kTPRecommendedUserModelEmail = @"email";
NSString *const kTPRecommendedUserModelNickname = @"nickname";
NSString *const kTPRecommendedUserModelUserId = @"userId";

@interface TPRecommendedUserModel ()
@end
@implementation TPRecommendedUserModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTPRecommendedUserModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = [dictionary[kTPRecommendedUserModelCreatedAt] integerValue];
	}
	if(![dictionary[kTPRecommendedUserModelEmail] isKindOfClass:[NSNull class]]){
		self.email = dictionary[kTPRecommendedUserModelEmail];
	}	
	if(![dictionary[kTPRecommendedUserModelNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kTPRecommendedUserModelNickname];
	}	
	if(![dictionary[kTPRecommendedUserModelUserId] isKindOfClass:[NSNull class]]){
		self.userId = [dictionary[kTPRecommendedUserModelUserId] integerValue];
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kTPRecommendedUserModelCreatedAt] = @(self.createdAt);
	if(self.email != nil){
		dictionary[kTPRecommendedUserModelEmail] = self.email;
	}
	if(self.nickname != nil){
		dictionary[kTPRecommendedUserModelNickname] = self.nickname;
	}
	dictionary[kTPRecommendedUserModelUserId] = @(self.userId);
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
	[aCoder encodeObject:@(self.createdAt) forKey:kTPRecommendedUserModelCreatedAt];	if(self.email != nil){
		[aCoder encodeObject:self.email forKey:kTPRecommendedUserModelEmail];
	}
	if(self.nickname != nil){
		[aCoder encodeObject:self.nickname forKey:kTPRecommendedUserModelNickname];
	}
	[aCoder encodeObject:@(self.userId) forKey:kTPRecommendedUserModelUserId];
}
/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.createdAt = [[aDecoder decodeObjectForKey:kTPRecommendedUserModelCreatedAt] integerValue];
	self.email = [aDecoder decodeObjectForKey:kTPRecommendedUserModelEmail];
	self.nickname = [aDecoder decodeObjectForKey:kTPRecommendedUserModelNickname];
	self.userId = [[aDecoder decodeObjectForKey:kTPRecommendedUserModelUserId] integerValue];
	return self;
}
/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	TPRecommendedUserModel *copy = [TPRecommendedUserModel new];
	copy.createdAt = self.createdAt;
	copy.email = [self.email copy];
	copy.nickname = [self.nickname copy];
	copy.userId = self.userId;
	return copy;
}
@end
