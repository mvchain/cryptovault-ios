//
//    TPMVCBankItemModel.h
//
//    Create by 蒲公英 on 4/4/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPMVCBankItemModel : NSObject

@property (nonatomic, strong) NSString * headImage;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat limitValue;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) NSInteger transactionType;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
