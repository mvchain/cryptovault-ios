//
//  MJdogGrey.m
//  TwoProject
//
//  Created by gumi on 2017/6/28.
//  Copyright © 2017年 gumi. All rights reserved.
//

#import "MJdogGrey.h"

@implementation MJdogGrey
- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片

    NSMutableArray *idleImages = [NSMutableArray array];
    //    for (NSUInteger i = 1; i<=60; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
    //        [idleImages addObject:image];
    //    }
    for(int  i=1;i<2;i++){//loader1_01
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loader2_%02d", i]];
        
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    //    for (NSUInteger i = 1; i<=3; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
    //        [refreshingImages addObject:image];
    //    }
    for(int  i=1;i<17;i++){//loader1_01
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loader2_%02d", i]];
        [refreshingImages addObject:image];
    }
    self.stateLabel.textColor = [UIColor whiteColor];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.labelLeftInset = 20;
    self.stateLabel.hidden = YES;
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages duration:17*0.03 forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:refreshingImages duration:17*0.03 forState:MJRefreshStateRefreshing];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
