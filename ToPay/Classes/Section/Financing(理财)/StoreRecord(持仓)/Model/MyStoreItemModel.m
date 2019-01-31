//
//    MyStoreItemModel.m
//
//    Create by 蒲公英 on 23/1/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MyStoreItemModel.h"

NSString *const kMyStoreItemModelBaseTokenName = @"baseTokenName";
NSString *const kMyStoreItemModelIdField = @"id";
NSString *const kMyStoreItemModelName = @"name";
NSString *const kMyStoreItemModelPartake = @"partake";
NSString *const kMyStoreItemModelTimes = @"times";
NSString *const kMyStoreItemModelTokenName = @"tokenName";
NSString *const kMyStoreItemModelValue = @"value";

@interface MyStoreItemModel ()
@end
@implementation MyStoreItemModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kMyStoreItemModelBaseTokenName] isKindOfClass:[NSNull class]]){
        self.baseTokenName = dictionary[kMyStoreItemModelBaseTokenName];
    }
    if(![dictionary[kMyStoreItemModelIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kMyStoreItemModelIdField] integerValue];
    }
    
    if(![dictionary[kMyStoreItemModelName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kMyStoreItemModelName];
    }
    if(![dictionary[kMyStoreItemModelPartake] isKindOfClass:[NSNull class]]){
        self.partake = [dictionary[kMyStoreItemModelPartake] floatValue];
    }
    
    if(![dictionary[kMyStoreItemModelTimes] isKindOfClass:[NSNull class]]){
        self.times = [dictionary[kMyStoreItemModelTimes] integerValue];
    }
    
    if(![dictionary[kMyStoreItemModelTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kMyStoreItemModelTokenName];
    }
    if(![dictionary[kMyStoreItemModelValue] isKindOfClass:[NSNull class]]){
        self.value = [dictionary[kMyStoreItemModelValue] floatValue];
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
        dictionary[kMyStoreItemModelBaseTokenName] = self.baseTokenName;
    }
    dictionary[kMyStoreItemModelIdField] = @(self.idField);
    if(self.name != nil){
        dictionary[kMyStoreItemModelName] = self.name;
    }
    dictionary[kMyStoreItemModelPartake] = @(self.partake);
    dictionary[kMyStoreItemModelTimes] = @(self.times);
    if(self.tokenName != nil){
        dictionary[kMyStoreItemModelTokenName] = self.tokenName;
    }
    dictionary[kMyStoreItemModelValue] = @(self.value);
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
        [aCoder encodeObject:self.baseTokenName forKey:kMyStoreItemModelBaseTokenName];
    }
    [aCoder encodeObject:@(self.idField) forKey:kMyStoreItemModelIdField];    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kMyStoreItemModelName];
    }
    [aCoder encodeObject:@(self.partake) forKey:kMyStoreItemModelPartake];    [aCoder encodeObject:@(self.times) forKey:kMyStoreItemModelTimes];    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kMyStoreItemModelTokenName];
    }
    [aCoder encodeObject:@(self.value) forKey:kMyStoreItemModelValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.baseTokenName = [aDecoder decodeObjectForKey:kMyStoreItemModelBaseTokenName];
    self.idField = [[aDecoder decodeObjectForKey:kMyStoreItemModelIdField] integerValue];
    self.name = [aDecoder decodeObjectForKey:kMyStoreItemModelName];
    self.partake = [[aDecoder decodeObjectForKey:kMyStoreItemModelPartake] floatValue];
    self.times = [[aDecoder decodeObjectForKey:kMyStoreItemModelTimes] integerValue];
    self.tokenName = [aDecoder decodeObjectForKey:kMyStoreItemModelTokenName];
    self.value = [[aDecoder decodeObjectForKey:kMyStoreItemModelValue] floatValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    MyStoreItemModel *copy = [MyStoreItemModel new];

    copy.baseTokenName = [self.baseTokenName copy];
    copy.idField = self.idField;
    copy.name = [self.name copy];
    copy.partake = self.partake;
    copy.times = self.times;
    copy.tokenName = [self.tokenName copy];
    copy.value = self.value;
    
    return copy;
}
@end
