//
//	TPRegisterInfoModel.m
//
//	Create by 蒲公英 on 14/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TPRegisterInfoModel.h"

NSString *const kTPRegisterInfoModelEmail = @"email";
NSString *const kTPRegisterInfoModelInviteCode = @"inviteCode";
NSString *const kTPRegisterInfoModelNickname = @"nickname";
NSString *const kTPRegisterInfoModelPassword = @"password";
NSString *const kTPRegisterInfoModelToken = @"token";
NSString *const kTPRegisterInfoModelTransactionPassword = @"transactionPassword";

@interface TPRegisterInfoModel ()
@end
@implementation TPRegisterInfoModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTPRegisterInfoModelEmail] isKindOfClass:[NSNull class]]){
		self.email = dictionary[kTPRegisterInfoModelEmail];
	}	
	if(![dictionary[kTPRegisterInfoModelInviteCode] isKindOfClass:[NSNull class]]){
		self.inviteCode = dictionary[kTPRegisterInfoModelInviteCode];
	}	
	if(![dictionary[kTPRegisterInfoModelNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kTPRegisterInfoModelNickname];
	}	
	if(![dictionary[kTPRegisterInfoModelPassword] isKindOfClass:[NSNull class]]){
		self.password = dictionary[kTPRegisterInfoModelPassword];
	}	
	if(![dictionary[kTPRegisterInfoModelToken] isKindOfClass:[NSNull class]]){
		self.token = dictionary[kTPRegisterInfoModelToken];
	}	
	if(![dictionary[kTPRegisterInfoModelTransactionPassword] isKindOfClass:[NSNull class]]){
		self.transactionPassword = dictionary[kTPRegisterInfoModelTransactionPassword];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.email != nil){
		dictionary[kTPRegisterInfoModelEmail] = self.email;
	}
	if(self.inviteCode != nil){
		dictionary[kTPRegisterInfoModelInviteCode] = self.inviteCode;
	}
	if(self.nickname != nil){
		dictionary[kTPRegisterInfoModelNickname] = self.nickname;
	}
	if(self.password != nil){
		dictionary[kTPRegisterInfoModelPassword] = self.password;
	}
	if(self.token != nil){
		dictionary[kTPRegisterInfoModelToken] = self.token;
	}
	if(self.transactionPassword != nil){
		dictionary[kTPRegisterInfoModelTransactionPassword] = self.transactionPassword;
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
	if(self.email != nil){
		[aCoder encodeObject:self.email forKey:kTPRegisterInfoModelEmail];
	}
	if(self.inviteCode != nil){
		[aCoder encodeObject:self.inviteCode forKey:kTPRegisterInfoModelInviteCode];
	}
	if(self.nickname != nil){
		[aCoder encodeObject:self.nickname forKey:kTPRegisterInfoModelNickname];
	}
	if(self.password != nil){
		[aCoder encodeObject:self.password forKey:kTPRegisterInfoModelPassword];
	}
	if(self.token != nil){
		[aCoder encodeObject:self.token forKey:kTPRegisterInfoModelToken];
	}
	if(self.transactionPassword != nil){
		[aCoder encodeObject:self.transactionPassword forKey:kTPRegisterInfoModelTransactionPassword];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.email = [aDecoder decodeObjectForKey:kTPRegisterInfoModelEmail];
	self.inviteCode = [aDecoder decodeObjectForKey:kTPRegisterInfoModelInviteCode];
	self.nickname = [aDecoder decodeObjectForKey:kTPRegisterInfoModelNickname];
	self.password = [aDecoder decodeObjectForKey:kTPRegisterInfoModelPassword];
	self.token = [aDecoder decodeObjectForKey:kTPRegisterInfoModelToken];
	self.transactionPassword = [aDecoder decodeObjectForKey:kTPRegisterInfoModelTransactionPassword];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	TPRegisterInfoModel *copy = [TPRegisterInfoModel new];

	copy.email = [self.email copy];
	copy.inviteCode = [self.inviteCode copy];
	copy.nickname = [self.nickname copy];
	copy.password = [self.password copy];
	copy.token = [self.token copy];
	copy.transactionPassword = [self.transactionPassword copy];

	return copy;
}
@end
