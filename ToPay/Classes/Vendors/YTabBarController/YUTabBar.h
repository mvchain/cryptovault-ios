//
//  YUTabBar.h
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUTabBarConfig.h"
#import "YUTabBarButton.h"
@class YUTabBar;


@protocol YUTabBarDelegate <NSObject>

- (void)tabBar:(YUTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface YUTabBar : UITabBar

- (instancetype)initWithFrame:(CGRect)frame norImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(YUTabBarConfig *)config;

/** 代理 */
@property (nonatomic, weak) id <YUTabBarDelegate>myDelegate;

/** selectedIndex (默认为0) */
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)changeTitles:(NSArray *)titleArr;
@end
