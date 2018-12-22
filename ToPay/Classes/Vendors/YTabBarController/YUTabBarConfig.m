//
//  YUTabBarConfig.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "YUTabBarConfig.h"
#import "YUTabBarButton.h"
#import "YUTabBarController.h"
@implementation YUTabBarConfig

static id _instance = nil;

+ (instancetype)config {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        [self configNormal];
    });
    return _instance;
}

- (void)configNormal {
    _norTitleColor = [UIColor colorWithHex:@"#808080"];
    _selTitleColor = [UIColor colorWithHex:@"#d81e06"];
    _isClearTabBarTopLine = YES;
    _tabBarTopLineColor = [UIColor lightGrayColor];
    _tabBarBackground = [UIColor whiteColor];
    _typeLayout = YUConfigTypeLayoutNormal;
    _imageSize = CGSizeMake(28, 28);
    _badgeTextColor = [UIColor colorWithHex:@"#FFFFFF"];
    _badgeBackgroundColor = [UIColor colorWithHex:@"#FF4040"];
    _titleFont = 12.f;
    _titleOffset = 2.f;
    _imageOffset = 2.f;
}

- (void)setBadgeSize:(CGSize)badgeSize {
    _badgeSize = badgeSize;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (YUTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset {
    _badgeOffset = badgeOffset;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (YUTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.left += badgeOffset.x;
        btn.badgeValue.badgeL.top += badgeOffset.y;
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (YUTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.textColor = badgeTextColor;
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    _badgeBackgroundColor = badgeBackgroundColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (YUTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.backgroundColor = badgeBackgroundColor;
    }
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    _badgeRadius = badgeRadius;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (YUTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.layer.cornerRadius = badgeRadius;
    }
}

- (void)badgeRadius:(CGFloat)radius AtIndex:(NSInteger)index {
    YUTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.layer.cornerRadius = radius;
}


- (void)showPointBadgeAtIndex:(NSInteger)index{
    YUTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = YUBadgeValueTypePoint;
}

- (void)showNewBadgeAtIndex:(NSInteger)index {
    YUTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.badgeL.text = @"new";
    tabBarButton.badgeValue.type = YUBadgeValueTypeNew;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index {
    YUTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.badgeL.text = badgeValue;
    tabBarButton.badgeValue.type = YUBadgeValueTypeNumber;
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    [self getTabBarButtonAtIndex:index].badgeValue.hidden = YES;
}

- (void)addCustomBtn:(UIButton *)btn AtIndex:(NSInteger)index BtnClickBlock:(YUConfigCustomBtnBlock)btnClickBlock {
    btn.tag = index;
    [btn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnClickBlock = btnClickBlock;
    [self.tabBarController.YU_TabBar addSubview:btn];
}

- (void)customBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(sender, sender.tag);
    }
}

- (YUTabBarButton *)getTabBarButtonAtIndex:(NSInteger)index {
    NSArray *subViews = self.tabBarController.YU_TabBar.subviews;
    for (int i = 0; i < subViews.count; i++) {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[YUTabBarButton class]] && i == index) {
            YUTabBarButton *tabBarBtn = (YUTabBarButton *)tabBarButton;
            return tabBarBtn;
        }
    }
    return nil;
}

- (NSMutableArray *)getTabBarButtons {
    NSArray *subViews = self.tabBarController.YU_TabBar.subviews;//self.tabBarController.YU_TabBar.subviews;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < subViews.count; i++) {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[YUTabBarButton class]]) {
            YUTabBarButton *tabBarBtn = (YUTabBarButton *)tabBarButton;
            [tempArr addObject:tabBarBtn];
        }
    }
    return tempArr;
}

@end
