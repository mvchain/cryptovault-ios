//
//	MyEveryDayIncomItemModel.h
//
//	Create by 蒲公英 on 23/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEveryDayIncomItemModel : NSObject

@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat income;
@property (nonatomic, strong) NSString * tokenName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
