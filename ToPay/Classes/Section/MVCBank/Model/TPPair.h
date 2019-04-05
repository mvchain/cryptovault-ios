//
//    TPPair.h
//
//    Create by 蒲公英 on 4/4/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPPair : NSObject

@property (nonatomic, assign) NSInteger increase;
@property (nonatomic, strong) NSString * pair;
@property (nonatomic, assign) NSInteger pairId;
@property (nonatomic, assign) NSInteger ratio;
@property (nonatomic, assign) NSInteger tokenId;
@property (nonatomic, strong) NSString * tokenImage;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) NSInteger transactionStatus;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
