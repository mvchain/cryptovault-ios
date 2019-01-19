//
//	TPRegisterResponseModel.h
//
//	Create by 蒲公英 on 14/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPRegisterResponseModel : NSObject <NSCoding>

@property (nonatomic, strong) NSArray * mnemonics;
@property (nonatomic, strong) NSString * privateKey;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
