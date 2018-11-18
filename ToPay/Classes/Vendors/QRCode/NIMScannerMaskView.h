//
//  NIMScannerMaskView.h
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 扫描遮罩视图
@interface NIMScannerMaskView : UIView

/// 使用裁切区域实例化遮罩视图
///
/// @param frame    视图区域
/// @param cropRect 裁切区域
///
/// @return 遮罩视图
+ (instancetype)maskViewWithFrame:(CGRect)frame cropRect:(CGRect)cropRect;

/// 裁切区域
@property (nonatomic) CGRect cropRect;

@end
