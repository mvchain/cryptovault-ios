//
//	FinProductDetailModel.h
//
//	Create by 蒲公英 on 22/1/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 code    integer($int32)
 data    理财购买详情{
 balance    number
 可用余额数量
 
 baseTokenId    integer
 参与币种id
 
 baseTokenName    string
 奖励币种名称
 
 content    string
 产品内容介绍
 
 id    integer
 产品id
 
 incomeMax    number($float)
 最大浮动年化
 
 incomeMin    number($float)
 最小浮动年化
 
 limitValue    number
 理财总量
 
 minValue    number
 最小购买量
 
 name    string
 产品名称
 
 purchased    number
 已购买数量
 
 ratio    number($float)
 兑换比例
 
 rule    string
 产品规则介绍
 
 startAt    integer($int64)
 开始日期
 
 stopAt    integer($int64)
 结束日期
 
 times    integer($int32)
 理财天数
 
 tokenId    integer
 奖励币种id
 
 tokenName    string
 奖励币种名称
 
 userLimit    number
 用户限购
 
 }
 message    string
 }

 */
//
//    FinProductDetailModel.h
//
//    Create by 蒲公英 on 22/1/2019
//    Copyright © 2019. All rights reserved.
//

//
//    FinProductDetailModel.h
//
//    Create by 蒲公英 on 22/1/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinProductDetailModel : NSObject

@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) NSInteger baseTokenId;
@property (nonatomic, strong) NSString * baseTokenName;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat incomeMax;
@property (nonatomic, assign) CGFloat incomeMin;
@property (nonatomic, assign) NSInteger limitValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger purchased;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSString * rule;
@property (nonatomic, assign) NSInteger startAt;
@property (nonatomic, assign) NSInteger stopAt;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) NSInteger tokenId;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) NSInteger userLimit;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end

