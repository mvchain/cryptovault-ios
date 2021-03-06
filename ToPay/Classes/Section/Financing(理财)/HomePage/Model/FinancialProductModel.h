//
//	FinancialProductModel.h
//
//	Create by 蒲公英 on 22/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Result«List«理财简略信息»»{
 code    integer($int32)
 data    [理财简略信息{
 baseTokenName    string
 基础货币名称
 
 id    integer
 理财项目id
 
 incomeMax    number($float)
 最大年化收益
 
 incomeMin    number($float)
 最小年化收益
 
 minValue    number
 最小购买数量
 
 name    string
 产品名称
 
 stopAt    integer($int64)
 结束时间戳
 
 times    integer($int32)
 产品期限（天）
 
 */
@interface FinancialProductModel : NSObject

@property (nonatomic, strong) NSString * baseTokenName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat incomeMax;
@property (nonatomic, assign) CGFloat incomeMin;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger stopAt;
@property (nonatomic, assign) NSInteger times;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
