//
//    TPMVCBankItemModel.m
//
//    Create by 蒲公英 on 4/4/2019
//    Copyright © 2019. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TPMVCBankItemModel.h"

NSString *const kTPMVCBankItemModelHeadImage = @"headImage";
NSString *const kTPMVCBankItemModelIdField = @"id";
NSString *const kTPMVCBankItemModelLimitValue = @"limitValue";
NSString *const kTPMVCBankItemModelNickname = @"nickname";
NSString *const kTPMVCBankItemModelPrice = @"price";
NSString *const kTPMVCBankItemModelTotal = @"total";
NSString *const kTPMVCBankItemModelTransactionType = @"transactionType";

@interface TPMVCBankItemModel ()
@end
@implementation TPMVCBankItemModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kTPMVCBankItemModelHeadImage] isKindOfClass:[NSNull class]]){
        self.headImage = dictionary[kTPMVCBankItemModelHeadImage];
    }
    if(![dictionary[kTPMVCBankItemModelIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kTPMVCBankItemModelIdField] integerValue];
    }
    
    if(![dictionary[kTPMVCBankItemModelLimitValue] isKindOfClass:[NSNull class]]){
        self.limitValue = [dictionary[kTPMVCBankItemModelLimitValue] doubleValue];
    }
    
    if(![dictionary[kTPMVCBankItemModelNickname] isKindOfClass:[NSNull class]]){
        self.nickname = dictionary[kTPMVCBankItemModelNickname];
    }
    if(![dictionary[kTPMVCBankItemModelPrice] isKindOfClass:[NSNull class]]){
        self.price = dictionary[kTPMVCBankItemModelPrice];
        
    }
    
    if(![dictionary[kTPMVCBankItemModelTotal] isKindOfClass:[NSNull class]]){
        self.total = [dictionary[kTPMVCBankItemModelTotal] doubleValue];
    }
    
    if(![dictionary[kTPMVCBankItemModelTransactionType] isKindOfClass:[NSNull class]]){
        self.transactionType = [dictionary[kTPMVCBankItemModelTransactionType] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.headImage != nil){
        dictionary[kTPMVCBankItemModelHeadImage] = self.headImage;
    }
    dictionary[kTPMVCBankItemModelIdField] = @(self.idField);
    dictionary[kTPMVCBankItemModelLimitValue] = @(self.limitValue);
    if(self.nickname != nil){
        dictionary[kTPMVCBankItemModelNickname] = self.nickname;
    }
    dictionary[kTPMVCBankItemModelPrice] = self.price;
    dictionary[kTPMVCBankItemModelTotal] = @(self.total);
    dictionary[kTPMVCBankItemModelTransactionType] = @(self.transactionType);
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
    if(self.headImage != nil){
        [aCoder encodeObject:self.headImage forKey:kTPMVCBankItemModelHeadImage];
    }
    [aCoder encodeObject:@(self.idField) forKey:kTPMVCBankItemModelIdField];    [aCoder encodeObject:@(self.limitValue) forKey:kTPMVCBankItemModelLimitValue];    if(self.nickname != nil){
        [aCoder encodeObject:self.nickname forKey:kTPMVCBankItemModelNickname];
    }
    [aCoder encodeObject:self.price forKey:kTPMVCBankItemModelPrice];    [aCoder encodeObject:@(self.total) forKey:kTPMVCBankItemModelTotal];    [aCoder encodeObject:@(self.transactionType) forKey:kTPMVCBankItemModelTransactionType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.headImage = [aDecoder decodeObjectForKey:kTPMVCBankItemModelHeadImage];
    self.idField = [[aDecoder decodeObjectForKey:kTPMVCBankItemModelIdField] integerValue];
    self.limitValue = [[aDecoder decodeObjectForKey:kTPMVCBankItemModelLimitValue] doubleValue];
    self.nickname = [aDecoder decodeObjectForKey:kTPMVCBankItemModelNickname];
    self.price = [aDecoder decodeObjectForKey:kTPMVCBankItemModelPrice] ;
    self.total = [[aDecoder decodeObjectForKey:kTPMVCBankItemModelTotal] doubleValue];
    self.transactionType = [[aDecoder decodeObjectForKey:kTPMVCBankItemModelTransactionType] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    TPMVCBankItemModel *copy = [TPMVCBankItemModel new];
    
    copy.headImage = [self.headImage copy];
    copy.idField = self.idField;
    copy.limitValue = self.limitValue;
    copy.nickname = [self.nickname copy];
    copy.price = self.price;
    copy.total = self.total;
    copy.transactionType = self.transactionType;
    
    return copy;
}
@end
