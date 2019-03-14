//
//    BlockBrowserCaptialItem.m
//
//    Create by 蒲公英 on 14/3/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BlockBrowserCaptialItem.h"

NSString *const kBlockBrowserCaptialItemTokenId = @"tokenId";
NSString *const kBlockBrowserCaptialItemTokenName = @"tokenName";
NSString *const kBlockBrowserCaptialItemValue = @"value";

@interface BlockBrowserCaptialItem ()
@end
@implementation BlockBrowserCaptialItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kBlockBrowserCaptialItemTokenId] isKindOfClass:[NSNull class]]){
        self.tokenId = [dictionary[kBlockBrowserCaptialItemTokenId] integerValue];
    }
    
    if(![dictionary[kBlockBrowserCaptialItemTokenName] isKindOfClass:[NSNull class]]){
        self.tokenName = dictionary[kBlockBrowserCaptialItemTokenName];
    }
    if(![dictionary[kBlockBrowserCaptialItemValue] isKindOfClass:[NSNull class]]){
        self.value = [dictionary[kBlockBrowserCaptialItemValue] doubleValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kBlockBrowserCaptialItemTokenId] = @(self.tokenId);
    if(self.tokenName != nil){
        dictionary[kBlockBrowserCaptialItemTokenName] = self.tokenName;
    }
    dictionary[kBlockBrowserCaptialItemValue] = @(self.value);
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
    [aCoder encodeObject:@(self.tokenId) forKey:kBlockBrowserCaptialItemTokenId];    if(self.tokenName != nil){
        [aCoder encodeObject:self.tokenName forKey:kBlockBrowserCaptialItemTokenName];
    }
    [aCoder encodeObject:@(self.value) forKey:kBlockBrowserCaptialItemValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.tokenId = [[aDecoder decodeObjectForKey:kBlockBrowserCaptialItemTokenId] integerValue];
    self.tokenName = [aDecoder decodeObjectForKey:kBlockBrowserCaptialItemTokenName];
    self.value = [[aDecoder decodeObjectForKey:kBlockBrowserCaptialItemValue] doubleValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    BlockBrowserCaptialItem *copy = [BlockBrowserCaptialItem new];
    
    copy.tokenId = self.tokenId;
    copy.tokenName = [self.tokenName copy];
    copy.value = self.value;
    
    return copy;
}
@end
