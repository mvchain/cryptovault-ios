//
//  NIMScannerBorder.m
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//

#import "NIMScannerBorder.h"

@implementation NIMScannerBorder
{
    /// 冲击波图像
    UIImageView *scannerLine;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
#pragma mark - 扫描动画方法
/// 开始扫描动画
- (void)startScannerAnimating {
    
    [self stopScannerAnimating];
    
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
    animations:^
    {
        [UIView setAnimationRepeatCount:MAXFLOAT];
        scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 5);
    }
        completion:nil];
}

/// 停止扫描动画
- (void)stopScannerAnimating {
    [scannerLine.layer removeAllAnimations];
    scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, 3);
}

#pragma mark - 设置界面
- (void)prepareUI
{
    self.clipsToBounds = YES;
    
    // 冲击波图像
    scannerLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qcode_line"]];
    
    scannerLine.frame = CGRectMake(0,0, self.bounds.size.width, scannerLine.bounds.size.height);
    scannerLine.center = CGPointMake(self.bounds.size.width * 0.5 , 0);
    
    [self addSubview:scannerLine];
    
    // 加载边框图像
    for (NSInteger i = 1; i < 5; i++)
    {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"BCScanQR%zd",i]]];
        
        [self addSubview:img];
        
        CGFloat offsetX = self.bounds.size.width - img.bounds.size.width;
        CGFloat offsetY = self.bounds.size.height - img.bounds.size.height;
        
        switch (i)
        {
            case 2:
                img.frame = CGRectOffset(img.frame, offsetX, 0);
                break;
            case 3:
                img.frame = CGRectOffset(img.frame, 0, offsetY);
                break;
            case 4:
                img.frame = CGRectOffset(img.frame, offsetX, offsetY);
                break;
            default:
                break;
        }
    }
}

@end
