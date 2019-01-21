//
//	TPRecommendedUserModel.h
//
//	Create by 蒲公英 on 21/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPRecommendedUserModel : NSObject

@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, assign) NSInteger userId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end