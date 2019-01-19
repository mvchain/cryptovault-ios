//
//	TPRegisterInfoModel.h
//
//	Create by 蒲公英 on 14/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPRegisterInfoModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * inviteCode;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * transactionPassword;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
