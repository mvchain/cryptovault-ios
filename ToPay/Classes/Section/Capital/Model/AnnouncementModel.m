//
//    AnnouncementModel.m
//
//    Create by 蒲公英 on 12/4/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AnnouncementModel.h"

NSString *const kAnnouncementModelContent = @"content";
NSString *const kAnnouncementModelCreatedAt = @"createdAt";
NSString *const kAnnouncementModelIdField = @"id";
NSString *const kAnnouncementModelTitle = @"title";

@interface AnnouncementModel ()
@end
@implementation AnnouncementModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAnnouncementModelContent] isKindOfClass:[NSNull class]]){
        self.content = dictionary[kAnnouncementModelContent];
    }
    if(![dictionary[kAnnouncementModelCreatedAt] isKindOfClass:[NSNull class]]){
        self.createdAt = [dictionary[kAnnouncementModelCreatedAt] integerValue];
    }
    
    if(![dictionary[kAnnouncementModelIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kAnnouncementModelIdField] integerValue];
    }
    
    if(![dictionary[kAnnouncementModelTitle] isKindOfClass:[NSNull class]]){
        self.title = dictionary[kAnnouncementModelTitle];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.content != nil){
        dictionary[kAnnouncementModelContent] = self.content;
    }
    dictionary[kAnnouncementModelCreatedAt] = @(self.createdAt);
    dictionary[kAnnouncementModelIdField] = @(self.idField);
    if(self.title != nil){
        dictionary[kAnnouncementModelTitle] = self.title;
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
    if(self.content != nil){
        [aCoder encodeObject:self.content forKey:kAnnouncementModelContent];
    }
    [aCoder encodeObject:@(self.createdAt) forKey:kAnnouncementModelCreatedAt];    [aCoder encodeObject:@(self.idField) forKey:kAnnouncementModelIdField];    if(self.title != nil){
        [aCoder encodeObject:self.title forKey:kAnnouncementModelTitle];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.content = [aDecoder decodeObjectForKey:kAnnouncementModelContent];
    self.createdAt = [[aDecoder decodeObjectForKey:kAnnouncementModelCreatedAt] integerValue];
    self.idField = [[aDecoder decodeObjectForKey:kAnnouncementModelIdField] integerValue];
    self.title = [aDecoder decodeObjectForKey:kAnnouncementModelTitle];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AnnouncementModel *copy = [AnnouncementModel new];
    
    copy.content = [self.content copy];
    copy.createdAt = self.createdAt;
    copy.idField = self.idField;
    copy.title = [self.title copy];
    
    return copy;
}
@end
