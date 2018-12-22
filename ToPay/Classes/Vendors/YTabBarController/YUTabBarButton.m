//
//  YUTabBarButton.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "YUTabBarButton.h"

@implementation YUTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:[[YUTabBarConfig config] titleFont]];
        [self addSubview:self.title];
        
        self.badgeValue = [[YUBadgeValue alloc] init];
        self.badgeValue.hidden = YES;
        [self addSubview:self.badgeValue];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize imageSize = [[YUTabBarConfig config] imageSize];
    CGFloat imageY = [[YUTabBarConfig config] imageOffset];
    if ([[YUTabBarConfig config] typeLayout] == YUConfigTypeLayoutImage) {
        imageY = self.height * 0.5 - imageSize.height * 0.5;
    }
    CGFloat iamgeX = self.width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 14.f;
    CGFloat titleW = self.width - 8;
    CGFloat titleY = self.height - titleH - [[YUTabBarConfig config] titleOffset];
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeH = 16;
    CGFloat badgeW = 24;
    self.badgeValue.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
}

- (void)setTypeLayout:(YUConfigTypeLayout)typeLayout {
    _typeLayout = typeLayout;
    
    if (typeLayout == YUConfigTypeLayoutImage) {
        self.title.hidden = YES;
        
        CGSize imageSize = [[YUTabBarConfig config] imageSize];
        
        CGFloat imageX = self.width * 0.5 - imageSize.width * 0.5;
        CGFloat imageY = self.height * 0.5 - imageSize.height * 0.5;
        self.imageView.frame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    }
}

@end
