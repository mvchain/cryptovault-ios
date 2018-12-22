//
//  YUBadgeValue.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "YUBadgeValue.h"

@implementation YUBadgeValue

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.badgeL = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeL.textColor = [[YUTabBarConfig config] badgeTextColor];
        self.badgeL.font = [UIFont systemFontOfSize:11.f];
        self.badgeL.textAlignment = NSTextAlignmentCenter;
        self.badgeL.layer.cornerRadius = 8.f;
        self.badgeL.layer.masksToBounds = YES;
        self.badgeL.backgroundColor = [[YUTabBarConfig config] badgeBackgroundColor];
        [self addSubview:self.badgeL];
    }
    return self;
}

- (void)setType:(YUBadgeValueType)type {
    _type = type;
    if (type == YUBadgeValueTypePoint) {
        self.badgeL.size = CGSizeMake(10, 10);
        self.badgeL.layer.cornerRadius = 5.f;
        self.badgeL.left = 0;
        self.badgeL.top = self.height * 0.5 - self.badgeL.size.height * 0.5;
    } else if (type == YUBadgeValueTypeNew) {
        self.badgeL.size = CGSizeMake(self.width, self.height);
    } else if (type == YUBadgeValueTypeNumber) {
        CGSize size = CGSizeZero;
        CGFloat radius = 8.f;
        if (self.badgeL.text.length <= 1) {
            size = CGSizeMake(self.height, self.height);
            radius = self.height * 0.5;
        } else if (self.badgeL.text.length > 1) {
            size = self.bounds.size;
            radius = 8.f;
        }
        self.badgeL.size = size;
        self.badgeL.layer.cornerRadius = radius;
    }
    
//    YUConfigBadgeAnimType animType = [[YUConfig config] animType];
//    if (animType == YUConfigBadgeAnimTypeShake) {   //抖动
//        [self.badgeL.layer addAnimation:[CAAnimation YU_ShakeAnimation_RepeatTimes:5] forKey:@"shakeAnimation"];
//    } else if (animType == YUConfigBadgeAnimTypeOpacity) { //透明过渡动画
//        [self.badgeL.layer addAnimation:[CAAnimation YU_OpacityAnimatioinDurTimes:0.3] forKey:@"opacityAniamtion"];
//    } else if (animType == YUConfigBadgeAnimTypeScale) { //缩放动画
//        [self.badgeL.layer addAnimation:[CAAnimation YU_ScaleAnimation] forKey:@"scaleAnimation"];
//    }
}

- (CGSize)sizeWithAttribute:(NSString *)text {
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeL.font}];
}

@end
