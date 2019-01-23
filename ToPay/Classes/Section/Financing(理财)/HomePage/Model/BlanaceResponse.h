//
//	BlanaceResponse.h
//
//	Create by 蒲公英 on 22/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlanaceResponse : NSObject

@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) CGFloat income;
@property (nonatomic, assign) CGFloat lastIncome;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
