//
//  YUTabBar.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "YUTabBar.h"

@interface YUTabBar ()
/** 存放JMTabBarButton数组 */
@property (nonatomic, strong) NSMutableArray *saveTabBarArrM;
/** norImage */
@property (nonatomic, strong) NSMutableArray *norImageArrM;
/** SelImage */
@property (nonatomic, strong) NSMutableArray *selImageArrM;
/** titleArr */
@property (nonatomic, strong) NSMutableArray *titleImageArrM;
@end

@implementation YUTabBar

- (NSMutableArray *)norImageArrM {
    if (!_norImageArrM) {
        _norImageArrM = [NSMutableArray array];
    }
    return _norImageArrM;
}

- (NSMutableArray *)selImageArrM {
    if (!_selImageArrM) {
        _selImageArrM = [NSMutableArray array];
    }
    return _selImageArrM;
}

- (NSMutableArray *)titleImageArrM {
    if (!_titleImageArrM) {
        _titleImageArrM = [NSMutableArray array];
    }
    return _titleImageArrM;
}

- (NSMutableArray *)saveTabBarArrM {
    if (!_saveTabBarArrM) {
        _saveTabBarArrM = [NSMutableArray array];
    }
    return _saveTabBarArrM;
}
- (void)changeTitles:(NSArray *)titleArr {
    for (int i = 0; i < titleArr.count; i++) {
        YUTabBarButton *tbBtn = self.saveTabBarArrM[i];
        
        tbBtn.title.text = titleArr[i];
    }
}
- (instancetype)initWithFrame:(CGRect)frame norImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(YUTabBarConfig *)config{
    if (self = [super initWithFrame:frame])
    {
        for (int i = 0; i < titleArr.count; i++) {
            YUTabBarButton *tbBtn = [[YUTabBarButton alloc] init];
            tbBtn.imageView.image = [UIImage imageNamed:norImageArr[i]];
            tbBtn.title.text = titleArr[i];
            tbBtn.title.textColor = [[YUTabBarConfig config] norTitleColor];
            tbBtn.typeLayout = config.typeLayout;
            tbBtn.tag = i;
            [self addSubview:tbBtn];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tbBtn addGestureRecognizer:tap];
            
            [self.saveTabBarArrM addObject:tbBtn];
            self.titleImageArrM = [NSMutableArray arrayWithArray:titleArr];
            self.norImageArrM = [NSMutableArray arrayWithArray:norImageArr];
            self.selImageArrM = [NSMutableArray arrayWithArray:selImageArr];
            
        }
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 5);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5;
        
        //背景颜色处理
        self.backgroundColor = [[YUTabBarConfig config] tabBarBackground];
        
        //顶部线条处理
        if (config.isClearTabBarTopLine) {
            [self topLineIsClearColor:YES];
        } else {
            [self topLineIsClearColor:NO];
        }
        
//        JMLog(@"%f",self.height);
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[YUTabBarButton class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArr addObject:tabBarButton];
        }
    }
    
    //进行排序
    for (int i = 0; i < tempArr.count; i++) {
        UIView *view = tempArr[i];
        if ([view isKindOfClass:[UIButton class]]) {
            [tempArr insertObject:view atIndex:view.tag];
            [tempArr removeLastObject];
            break;
        }
    }
    
    CGFloat viewW = self.width / tempArr.count;
    CGFloat viewH = 49;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArr.count; i++) {
        CGFloat viewX = i * viewW;
        UIView *view = tempArr[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    [self setUpSelectedIndex:tap.view.tag];
    
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [self.myDelegate tabBar:self didSelectIndex:tap.view.tag];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    [self setUpSelectedIndex:selectedIndex];
}

#pragma mark - 设置选中的index进行操作
- (void)setUpSelectedIndex:(NSInteger)selectedIndex {
    for (int i = 0; i < self.saveTabBarArrM.count; i++) {
        YUTabBarButton *tbBtn = self.saveTabBarArrM[i];
        if (i == selectedIndex)
        {
            tbBtn.title.textColor = [[YUTabBarConfig config] selTitleColor];
            tbBtn.imageView.image = [UIImage imageNamed:self.selImageArrM[i]];

            
//            if (type == JMConfigTabBarAnimTypeRotationY) {
//                [tbBtn.imageView.layer addAnimation:[CAAnimation JM_TabBarRotationY] forKey:@"rotateAnimation"];
            }
//        YUConfigTabBarAnimType type = [[YUTabBarConfig config] tabBarAnimType];
//        if (type == YUConfigTabBarAnimTypeScale)
//            {
//
//                CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//                CGPoint point = tbBtn.imageView.frame.origin;
//                point.y -= 15;
//                anim.toValue = [NSNumber numberWithFloat:point.y];
//
//                CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//                anim1.toValue = [NSNumber numberWithFloat:1.3f];
//
//                CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
//                groupAnimation.fillMode = kCAFillModeForwards;
//                groupAnimation.removedOnCompletion = NO;
//                groupAnimation.animations = [NSArray arrayWithObjects:anim,anim1, nil];
        
//                [tbBtn.imageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
//             }
//                else if (type == JMConfigTabBarAnimTypeBoundsMin) {
//                [tbBtn.imageView.layer addAnimation:[CAAnimation JM_TabBarBoundsMin] forKey:@"min"];
//            } else if (type == JMConfigTabBarAnimTypeBoundsMax) {
//                [tbBtn.imageView.layer addAnimation:[CAAnimation JM_TabBarBoundsMax] forKey:@"max"];
//            }
//        }
        else
        {
            tbBtn.title.textColor = [[YUTabBarConfig config] norTitleColor];
            tbBtn.imageView.image = [UIImage imageNamed:self.norImageArrM[i]];
            [tbBtn.imageView.layer removeAllAnimations];
        }
    }
}

#pragma mark - 顶部线条处理(清除颜色)
- (void)topLineIsClearColor:(BOOL)isClearColor {
    UIColor *color = [UIColor clearColor];
    if (!isClearColor) {
        color = [[YUTabBarConfig config] tabBarTopLineColor];
    }
    
    CGRect rect = CGRectMake(0, 0, self.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

@end
