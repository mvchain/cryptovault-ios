//
//  YUTabBarController.h
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUTabBarConfig.h"
#import "YUTabBar.h"

//@class YUTabBarConfig;

@interface YUTabBarController : UITabBarController

- (instancetype)config;


- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(YUTabBarConfig *)config;

/** tabBar */
@property (nonatomic, strong) YUTabBar *YU_TabBar;

@end
