//
//  UIImageView+YUExtension.h
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/18.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YUExtension)

-(void)setHeader:(NSString *)url;

-(void)setRectHeader:(NSString *)url;

-(void)setIconHeader:(NSString *)url placeholderImage:(NSString *)placeholderImage;

-(void)setRefreshIconHeader:(NSString *)url placeholderImage:(NSString *)placeholderImage;

//

@end
