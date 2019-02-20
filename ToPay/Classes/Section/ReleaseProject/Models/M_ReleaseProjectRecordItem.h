//
//	M_ReleaseProjectRecordItem.h
//
//	Create by 蒲公英 on 18/2/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 createdAt    integer($int64)
 创建时间
 
 id    integer
 记录id
 
 tokenId    integer
 币种id
 
 tokenName    string
 币种名称
 
 value    number
 数量
 */
@interface M_ReleaseProjectRecordItem : NSObject

@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger tokenId;
@property (nonatomic, strong) NSString * tokenName;
@property (nonatomic, assign) CGFloat value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
