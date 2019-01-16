//
//  UIButton+YUButtonStyle.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIButton (YUButtonStyle)
- (void)gradualChangeStyle ; // 渐变样式
- (void)allWhiteStyle ; // 全白样式
- (void)whiteBorderStyle; // 白色边框样式(内部透明)
- (void)rectBlackBorderStyle;// 黑色矩形（内部透明）
- (void)rectGrayBorderStyle; // 灰色矩形（内部透明）

@end


