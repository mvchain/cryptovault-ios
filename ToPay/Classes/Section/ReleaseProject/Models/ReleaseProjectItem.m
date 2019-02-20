//
//	ReleaseProjectItem.m
//
//	Create by 蒲公英 on 18/2/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ReleaseProjectItem.h"

NSString *const kReleaseProjectItemProjectId = @"projectId";
NSString *const kReleaseProjectItemProjectImage = @"projectImage";
NSString *const kReleaseProjectItemProjectName = @"projectName";
NSString *const kReleaseProjectItemPublishTime = @"publishTime";
NSString *const kReleaseProjectItemReleaseValue = @"releaseValue";

@interface ReleaseProjectItem ()
@end
@implementation ReleaseProjectItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kReleaseProjectItemProjectId] isKindOfClass:[NSNull class]]){
		self.projectId = [dictionary[kReleaseProjectItemProjectId] integerValue];
	}

	if(![dictionary[kReleaseProjectItemProjectImage] isKindOfClass:[NSNull class]]){
		self.projectImage = dictionary[kReleaseProjectItemProjectImage];
	}	
	if(![dictionary[kReleaseProjectItemProjectName] isKindOfClass:[NSNull class]]){
		self.projectName = dictionary[kReleaseProjectItemProjectName];
	}	
	if(![dictionary[kReleaseProjectItemPublishTime] isKindOfClass:[NSNull class]]){
		self.publishTime = [dictionary[kReleaseProjectItemPublishTime] integerValue];
	}

	if(![dictionary[kReleaseProjectItemReleaseValue] isKindOfClass:[NSNull class]]){
		self.releaseValue = [dictionary[kReleaseProjectItemReleaseValue] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kReleaseProjectItemProjectId] = @(self.projectId);
	if(self.projectImage != nil){
		dictionary[kReleaseProjectItemProjectImage] = self.projectImage;
	}
	if(self.projectName != nil){
		dictionary[kReleaseProjectItemProjectName] = self.projectName;
	}
	dictionary[kReleaseProjectItemPublishTime] = @(self.publishTime);
	dictionary[kReleaseProjectItemReleaseValue] = @(self.releaseValue);
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
	[aCoder encodeObject:@(self.projectId) forKey:kReleaseProjectItemProjectId];	if(self.projectImage != nil){
		[aCoder encodeObject:self.projectImage forKey:kReleaseProjectItemProjectImage];
	}
	if(self.projectName != nil){
		[aCoder encodeObject:self.projectName forKey:kReleaseProjectItemProjectName];
	}
	[aCoder encodeObject:@(self.publishTime) forKey:kReleaseProjectItemPublishTime];	[aCoder encodeObject:@(self.releaseValue) forKey:kReleaseProjectItemReleaseValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.projectId = [[aDecoder decodeObjectForKey:kReleaseProjectItemProjectId] integerValue];
	self.projectImage = [aDecoder decodeObjectForKey:kReleaseProjectItemProjectImage];
	self.projectName = [aDecoder decodeObjectForKey:kReleaseProjectItemProjectName];
	self.publishTime = [[aDecoder decodeObjectForKey:kReleaseProjectItemPublishTime] integerValue];
	self.releaseValue = [[aDecoder decodeObjectForKey:kReleaseProjectItemReleaseValue] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ReleaseProjectItem *copy = [ReleaseProjectItem new];

	copy.projectId = self.projectId;
	copy.projectImage = [self.projectImage copy];
	copy.projectName = [self.projectName copy];
	copy.publishTime = self.publishTime;
	copy.releaseValue = self.releaseValue;

	return copy;
}
@end
