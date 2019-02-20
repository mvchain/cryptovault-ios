//
//    M_ReleaseProjectJoinedDetail.m
//
//    Create by 蒲公英 on 18/2/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ReleaseProjectJoinedDetail.h"

NSString *const kM_ReleaseProjectJoinedDetailBaseTokenId = @"baseTokenId";
NSString *const kM_ReleaseProjectJoinedDetailBaseTokenName = @"baseTokenName";
NSString *const kM_ReleaseProjectJoinedDetailCreatedAt = @"createdAt";
NSString *const kM_ReleaseProjectJoinedDetailPayed = @"payed";
NSString *const kM_ReleaseProjectJoinedDetailProjectId = @"projectId";
NSString *const kM_ReleaseProjectJoinedDetailProjectImage = @"projectImage";
NSString *const kM_ReleaseProjectJoinedDetailProjectLimit = @"projectLimit";
NSString *const kM_ReleaseProjectJoinedDetailProjectName = @"projectName";
NSString *const kM_ReleaseProjectJoinedDetailRatio = @"ratio";
NSString *const kM_ReleaseProjectJoinedDetailReleaseValue = @"releaseValue";
NSString *const kM_ReleaseProjectJoinedDetailStartedAt = @"startedAt";
NSString *const kM_ReleaseProjectJoinedDetailStatus = @"status";
NSString *const kM_ReleaseProjectJoinedDetailStopAt = @"stopAt";
NSString *const kM_ReleaseProjectJoinedDetailSuccessPayed = @"successPayed";
NSString *const kM_ReleaseProjectJoinedDetailSuccessValue = @"successValue";
NSString *const kM_ReleaseProjectJoinedDetailTokenId = @"tokenId";
NSString *const kM_ReleaseProjectJoinedDetailTokenName = @"tokenName";
NSString *const kM_ReleaseProjectJoinedDetailTotal = @"total";
NSString *const kM_ReleaseProjectJoinedDetailUpdatedAt = @"updatedAt";
NSString *const kM_ReleaseProjectJoinedDetailValue = @"value";

@interface M_ReleaseProjectJoinedDetail ()
@end
@implementation M_ReleaseProjectJoinedDetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kM_ReleaseProjectJoinedDetailBaseTokenId] isKindOfClass:[NSNull class]]){
        self.baseTokenId = [dictionary[kM_ReleaseProjectJoinedDetailBaseTokenId] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailBaseTokenName] isKindOfClass:[NSNull class]]){
        self.baseTokenName = dictionary[kM_ReleaseProjectJoinedDetailBaseTokenName];
    }
    if(![dictionary[kM_ReleaseProjectJoinedDetailCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kM_ReleaseProjectJoinedDetailCreatedAt] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailPayed] isKindOfClass:[NSNull class]]){
        self.payed = [dictionary[kM_ReleaseProjectJoinedDetailPayed] floatValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailProjectId] isKindOfClass:[NSNull class]]){
        self.projectId = [dictionary[kM_ReleaseProjectJoinedDetailProjectId] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailProjectImage] isKindOfClass:[NSNull class]]){
        self.projectImage = dictionary[kM_ReleaseProjectJoinedDetailProjectImage];
    }
    if(![dictionary[kM_ReleaseProjectJoinedDetailProjectLimit] isKindOfClass:[NSNull class]]){
        self.projectLimit = [dictionary[kM_ReleaseProjectJoinedDetailProjectLimit] floatValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailProjectName] isKindOfClass:[NSNull class]]){
        self.projectName = dictionary[kM_ReleaseProjectJoinedDetailProjectName];
    }
    if(![dictionary[kM_ReleaseProjectJoinedDetailRatio] isKindOfClass:[NSNull class]]){
        self.ratio = [dictionary[kM_ReleaseProjectJoinedDetailRatio] floatValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailReleaseValue] isKindOfClass:[NSNull class]]){
        self.releaseValue = [dictionary[kM_ReleaseProjectJoinedDetailReleaseValue] floatValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailStartedAt] isKindOfClass:[NSNull class]]){
        self.startedAt = [dictionary[kM_ReleaseProjectJoinedDetailStartedAt] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailStatus] isKindOfClass:[NSNull class]]){
        self.status = [dictionary[kM_ReleaseProjectJoinedDetailStatus] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailStopAt] isKindOfClass:[NSNull class]]){
        self.stopAt = [dictionary[kM_ReleaseProjectJoinedDetailStopAt] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailSuccessPayed] isKindOfClass:[NSNull class]]){
        self.successPayed = [dictionary[kM_ReleaseProjectJoinedDetailSuccessPayed] floatValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailSuccessValue] isKindOfClass:[NSNull class]]){
        self.successValue = [dictionary[kM_ReleaseProjectJoinedDetailSuccessValue] floatValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailTokenId] isKindOfClass:[NSNull class]]){
        self.tokenId = [dictionary[kM_ReleaseProjectJoinedDetailTokenId] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kM_ReleaseProjectJoinedDetailTokenName];
    }
    if(![dictionary[kM_ReleaseProjectJoinedDetailTotal] isKindOfClass:[NSNull class]]){
        self.total = [dictionary[kM_ReleaseProjectJoinedDetailTotal] doubleValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailUpdatedAt] isKindOfClass:[NSNull class]]){
        self.updatedAt = [dictionary[kM_ReleaseProjectJoinedDetailUpdatedAt] integerValue];
    }
    
    if(![dictionary[kM_ReleaseProjectJoinedDetailValue] isKindOfClass:[NSNull class]]){
        self.value = [dictionary[kM_ReleaseProjectJoinedDetailValue] floatValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kM_ReleaseProjectJoinedDetailBaseTokenId] = @(self.baseTokenId);
    if(self.baseTokenName != nil){
        dictionary[kM_ReleaseProjectJoinedDetailBaseTokenName] = self.baseTokenName;
    }
    dictionary[kM_ReleaseProjectJoinedDetailCreatedAt] = @(self.createdAt);
    dictionary[kM_ReleaseProjectJoinedDetailPayed] = @(self.payed);
    dictionary[kM_ReleaseProjectJoinedDetailProjectId] = @(self.projectId);
    if(self.projectImage != nil){
        dictionary[kM_ReleaseProjectJoinedDetailProjectImage] = self.projectImage;
    }
    dictionary[kM_ReleaseProjectJoinedDetailProjectLimit] = @(self.projectLimit);
    if(self.projectName != nil){
        dictionary[kM_ReleaseProjectJoinedDetailProjectName] = self.projectName;
    }
    dictionary[kM_ReleaseProjectJoinedDetailRatio] = @(self.ratio);
    dictionary[kM_ReleaseProjectJoinedDetailReleaseValue] = @(self.releaseValue);
    dictionary[kM_ReleaseProjectJoinedDetailStartedAt] = @(self.startedAt);
    dictionary[kM_ReleaseProjectJoinedDetailStatus] = @(self.status);
    dictionary[kM_ReleaseProjectJoinedDetailStopAt] = @(self.stopAt);
    dictionary[kM_ReleaseProjectJoinedDetailSuccessPayed] = @(self.successPayed);
    dictionary[kM_ReleaseProjectJoinedDetailSuccessValue] = @(self.successValue);
    dictionary[kM_ReleaseProjectJoinedDetailTokenId] = @(self.tokenId);
    if(self.tokenName != nil){
        dictionary[kM_ReleaseProjectJoinedDetailTokenName] = self.tokenName;
    }
    dictionary[kM_ReleaseProjectJoinedDetailTotal] = @(self.total);
    dictionary[kM_ReleaseProjectJoinedDetailUpdatedAt] = @(self.updatedAt);
    dictionary[kM_ReleaseProjectJoinedDetailValue] = @(self.value);
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
    [aCoder encodeObject:@(self.baseTokenId) forKey:kM_ReleaseProjectJoinedDetailBaseTokenId];    if(self.baseTokenName != nil){
        [aCoder encodeObject:self.baseTokenName forKey:kM_ReleaseProjectJoinedDetailBaseTokenName];
    }
    [aCoder encodeObject:@(self.createdAt) forKey:kM_ReleaseProjectJoinedDetailCreatedAt];    [aCoder encodeObject:@(self.payed) forKey:kM_ReleaseProjectJoinedDetailPayed];    [aCoder encodeObject:@(self.projectId) forKey:kM_ReleaseProjectJoinedDetailProjectId];    if(self.projectImage != nil){
        [aCoder encodeObject:self.projectImage forKey:kM_ReleaseProjectJoinedDetailProjectImage];
    }
    [aCoder encodeObject:@(self.projectLimit) forKey:kM_ReleaseProjectJoinedDetailProjectLimit];    if(self.projectName != nil){
        [aCoder encodeObject:self.projectName forKey:kM_ReleaseProjectJoinedDetailProjectName];
    }
    [aCoder encodeObject:@(self.ratio) forKey:kM_ReleaseProjectJoinedDetailRatio];    [aCoder encodeObject:@(self.releaseValue) forKey:kM_ReleaseProjectJoinedDetailReleaseValue];    [aCoder encodeObject:@(self.startedAt) forKey:kM_ReleaseProjectJoinedDetailStartedAt];    [aCoder encodeObject:@(self.status) forKey:kM_ReleaseProjectJoinedDetailStatus];    [aCoder encodeObject:@(self.stopAt) forKey:kM_ReleaseProjectJoinedDetailStopAt];    [aCoder encodeObject:@(self.successPayed) forKey:kM_ReleaseProjectJoinedDetailSuccessPayed];    [aCoder encodeObject:@(self.successValue) forKey:kM_ReleaseProjectJoinedDetailSuccessValue];    [aCoder encodeObject:@(self.tokenId) forKey:kM_ReleaseProjectJoinedDetailTokenId];    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kM_ReleaseProjectJoinedDetailTokenName];
    }
    [aCoder encodeObject:@(self.total) forKey:kM_ReleaseProjectJoinedDetailTotal];    [aCoder encodeObject:@(self.updatedAt) forKey:kM_ReleaseProjectJoinedDetailUpdatedAt];    [aCoder encodeObject:@(self.value) forKey:kM_ReleaseProjectJoinedDetailValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.baseTokenId = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailBaseTokenId] integerValue];
    self.baseTokenName = [aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailBaseTokenName];
    self.createdAt = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailCreatedAt] integerValue];
    self.payed = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailPayed] floatValue];
    self.projectId = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailProjectId] integerValue];
    self.projectImage = [aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailProjectImage];
    self.projectLimit = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailProjectLimit] floatValue];
    self.projectName = [aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailProjectName];
    self.ratio = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailRatio] floatValue];
    self.releaseValue = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailReleaseValue] floatValue];
    self.startedAt = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailStartedAt] integerValue];
    self.status = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailStatus] integerValue];
    self.stopAt = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailStopAt] integerValue];
    self.successPayed = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailSuccessPayed] floatValue];
    self.successValue = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailSuccessValue] floatValue];
    self.tokenId = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailTokenId] integerValue];
    self.tokenName = [aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailTokenName];
    self.total = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailTotal] doubleValue];
    self.updatedAt = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailUpdatedAt] integerValue];
    self.value = [[aDecoder decodeObjectForKey:kM_ReleaseProjectJoinedDetailValue] floatValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    M_ReleaseProjectJoinedDetail *copy = [M_ReleaseProjectJoinedDetail new];
    
    copy.baseTokenId = self.baseTokenId;
    copy.baseTokenName = [self.baseTokenName copy];
    copy.createdAt = self.createdAt;
    copy.payed = self.payed;
    copy.projectId = self.projectId;
    copy.projectImage = [self.projectImage copy];
    copy.projectLimit = self.projectLimit;
    copy.projectName = [self.projectName copy];
    copy.ratio = self.ratio;
    copy.releaseValue = self.releaseValue;
    copy.startedAt = self.startedAt;
    copy.status = self.status;
    copy.stopAt = self.stopAt;
    copy.successPayed = self.successPayed;
    copy.successValue = self.successValue;
    copy.tokenId = self.tokenId;
    copy.tokenName = [self.tokenName copy];
    copy.total = self.total;
    copy.updatedAt = self.updatedAt;
    copy.value = self.value;
    
    return copy;
}
@end
