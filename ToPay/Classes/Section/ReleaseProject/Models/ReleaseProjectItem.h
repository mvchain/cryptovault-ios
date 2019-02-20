//
//	ReleaseProjectItem.h
//
//	Create by 蒲公英 on 18/2/2019
//	Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 projectId    integer
 项目id
 
 projectImage    string
 项目图片
 
 projectName    string
 项目名称
 
 publishTime    integer($int64)
 发币时间
 
 releaseValue    number($float)
 释放比例
 
 */
@interface ReleaseProjectItem : NSObject

@property (nonatomic, assign) NSInteger projectId;
@property (nonatomic, strong) NSString * projectImage;
@property (nonatomic, strong) NSString * projectName;
@property (nonatomic, assign) NSInteger publishTime;
@property (nonatomic, assign) CGFloat releaseValue;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
