//
//  NIMScannerBorder.h
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 扫描框视图
@interface NIMScannerBorder : UIView

/// 开始扫描动画
- (void)startScannerAnimating;
/// 停止扫描动画
- (void)stopScannerAnimating;

@end
