//
//  UIView+TPExtension.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "UIView+TPExtension.h"

@implementation UIView (TPExtension)

-(void)setLayerCornerRadius:(CGFloat)radius WithColor:(UIColor *)color WithBorderWidth:(CGFloat)width
{
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

-(void)setLayer:(CGFloat)color WithBackColor:(UIColor *)backColor
{
    self.layer.cornerRadius = color;
    self.backgroundColor = backColor;
}

@end
