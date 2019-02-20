//
//	M_ReleaseProjectJoinedDetail.h
//
//	Create by 蒲公英 on 18/2/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 发币数据详情{
 baseTokenId    integer
 基础货币id
 
 baseTokenName    string
 基础货币缩写
 
 createdAt    integer($int64)
 项目创建时间
 
 payed    number
 支付金额
 
 projectId    integer
 项目id
 
 projectImage    string
 项目图标
 
 projectLimit    number
 限购
 
 projectName    string
 项目名称
 
 ratio    number($float)
 基础货币兑换比例
 
 releaseValue    number($float)
 释放比例
 
 startedAt    integer($int64)
 开始时间
 
 status    integer($int32)
 项目状态0即将开始 1进行中 2已结束
 
 stopAt    integer($int64)
 结束时间
 
 successPayed    number
 成功支付金额
 
 successValue    number
 成功预约数量
 
 tokenId    integer
 货币id
 
 tokenName    string
 币种名称
 
 total    number
 众筹规模
 
 updatedAt    integer($int64)
 项目更新时间
 
 value    number
 预约数量
 
 }
 message    string
 }
 401

 */
//
//    M_ReleaseProjectJoinedDetail.h
//
//    Create by 蒲公英 on 18/2/2019
//    Copyright © 2019. All rights reserved.
//


@interface M_ReleaseProjectJoinedDetail : NSObject

@property (nonatomic, assign) NSInteger baseTokenId;
@property (nonatomic, strong) NSString * baseTokenName;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) CGFloat payed;
@property (nonatomic, assign) NSInteger projectId;
@property (nonatomic, strong) NSString * projectImage;
@property (nonatomic, assign) CGFloat projectLimit;
@property (nonatomic, strong) NSString * projectName;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) CGFloat releaseValue;
@property (nonatomic, assign) NSInteger startedAt;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger stopAt;
@property (nonatomic, assign) CGFloat successPayed;
@property (nonatomic, assign) CGFloat successValue;
@property (nonatomic, assign) NSInteger tokenId;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, assign) CGFloat value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
