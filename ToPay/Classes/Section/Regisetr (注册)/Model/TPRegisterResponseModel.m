//
//	TPRegisterResponseModel.m
//
//	Create by 蒲公英 on 14/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TPRegisterResponseModel.h"

NSString *const kTPRegisterResponseModelMnemonics = @"mnemonics";
NSString *const kTPRegisterResponseModelPrivateKey = @"privateKey";

@interface TPRegisterResponseModel ()
@end
@implementation TPRegisterResponseModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTPRegisterResponseModelMnemonics] isKindOfClass:[NSNull class]]){
		self.mnemonics = dictionary[kTPRegisterResponseModelMnemonics];
	}	
	if(![dictionary[kTPRegisterResponseModelPrivateKey] isKindOfClass:[NSNull class]]){
		self.privateKey = dictionary[kTPRegisterResponseModelPrivateKey];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.mnemonics != nil){
		dictionary[kTPRegisterResponseModelMnemonics] = self.mnemonics;
	}
	if(self.privateKey != nil){
		dictionary[kTPRegisterResponseModelPrivateKey] = self.privateKey;
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
	if(self.mnemonics != nil){
		[aCoder encodeObject:self.mnemonics forKey:kTPRegisterResponseModelMnemonics];
	}
	if(self.privateKey != nil){
		[aCoder encodeObject:self.privateKey forKey:kTPRegisterResponseModelPrivateKey];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.mnemonics = [aDecoder decodeObjectForKey:kTPRegisterResponseModelMnemonics];
	self.privateKey = [aDecoder decodeObjectForKey:kTPRegisterResponseModelPrivateKey];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	TPRegisterResponseModel *copy = [TPRegisterResponseModel new];

	copy.mnemonics = [self.mnemonics copy];
	copy.privateKey = [self.privateKey copy];

	return copy;
}
@end