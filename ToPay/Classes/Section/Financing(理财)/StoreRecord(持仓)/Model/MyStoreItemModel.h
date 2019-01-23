//
//	MyStoreItemModel.h
//
//	Create by 蒲公英 on 23/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 baseTokenName    string
 基础货币名称
 
 id    integer
 记录id
 
 name    string
 理财项目名称
 
 partake    number
 持仓金额
 
 times    integer($int32)
 剩余提取次数
 
 tokenName    string
 货币名称
 
 value    number
 收益
 */
//
//    MyStoreItemModel.h
//
//    Create by 蒲公英 on 23/1/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStoreItemModel : NSObject

@property (nonatomic, strong) NSString * baseTokenName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) CGFloat partake;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) CGFloat value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
