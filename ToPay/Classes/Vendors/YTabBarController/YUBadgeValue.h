//
//  YUBadgeValue.h
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//
//pod 'RDVTabBarController' to your Podfile.

#import <UIKit/UIKit.h>
#import "YUTabBarConfig.h"

typedef NS_ENUM(NSInteger, YUBadgeValueType) {
    YUBadgeValueTypePoint, //点
    YUBadgeValueTypeNew, //new
    YUBadgeValueTypeNumber, //number
};

@interface YUBadgeValue : UIView

/** badgeL */
@property (nonatomic, strong) UILabel *badgeL;

/** type */
@property (nonatomic, assign) YUBadgeValueType type;

@end
