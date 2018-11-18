//
//  UIView+TPExtension.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TPExtension)

-(void)setLayerCornerRadius:(CGFloat)radius WithColor:(UIColor *)color WithBorderWidth:(CGFloat)width;

-(void)setLayer:(CGFloat)color WithBackColor:(UIColor *)backColor;

@end
