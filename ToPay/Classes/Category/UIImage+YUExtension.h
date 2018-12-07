//
//  UIImage+YUExtension.h
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/18.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YUExtension)
/**
 *  返回圆形图片
 */
-(instancetype)circleImage;

+(instancetype)circleImage:(NSString *)name;

//-(UIImage *)imageForAvatarUpload;

@end
