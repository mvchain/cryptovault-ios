//
//  UIImage+YUExtension.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/18.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "UIImage+YUExtension.h"
//#import "YDevice.h"
@implementation UIImage (YUExtension)

-(instancetype)circleImage
{
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    //山下文
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx,rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //绘制图片
    [self drawInRect:rect];
    
    //获得图片
    UIImage *iamge = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return iamge;
}

+(instancetype)circleImage:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

//- (UIImage *)imageForAvatarUpload
//{
//    CGFloat pixels = [[YDevice currentDevice] suggestImagePixels];
//    UIImage * image = [self imageForUpload:pixels];
//    return [image fixOrientation];
//}

#pragma mark - Private

//- (UIImage *)imageForUpload: (CGFloat)suggestPixels
//{
//    const CGFloat kMaxPixels = 4000000;
//    const CGFloat kMaxRatio  = 3;
//
//    CGFloat width = self.size.width;
//    CGFloat height= self.size.height;
//
//    //对于超过建议像素，且长宽比超过max ratio的图做特殊处理
//    if (width * height > suggestPixels &&
//        (width / height > kMaxRatio || height / width > kMaxRatio))
//    {
//        return [self scaleWithMaxPixels:kMaxPixels];
//    }
//    else
//    {
//        return [self scaleWithMaxPixels:suggestPixels];
//    }
//}
//
//- (UIImage *)scaleWithMaxPixels: (CGFloat)maxPixels
//{
//    CGFloat width = self.size.width;
//    CGFloat height= self.size.height;
//    if (width * height < maxPixels || maxPixels == 0)
//    {
//        return self;
//    }
//    CGFloat ratio = sqrt(width * height / maxPixels);
//    if (fabs(ratio - 1) <= 0.01)
//    {
//        return self;
//    }
//    CGFloat newSizeWidth = width / ratio;
//    CGFloat newSizeHeight= height/ ratio;
//    return [self scaleToSize:CGSizeMake(newSizeWidth, newSizeHeight)];
//}
//
////内缩放，一条变等于最长边，另外一条小于等于最长边
//- (UIImage *)scaleToSize:(CGSize)newSize
//{
//    CGFloat width = self.size.width;
//    CGFloat height= self.size.height;
//    CGFloat newSizeWidth = newSize.width;
//    CGFloat newSizeHeight= newSize.height;
//    if (width <= newSizeWidth &&
//        height <= newSizeHeight)
//    {
//        return self;
//    }
//
//    if (width == 0 || height == 0 || newSizeHeight == 0 || newSizeWidth == 0)
//    {
//        return nil;
//    }
//    CGSize size;
//    if (width / height > newSizeWidth / newSizeHeight)
//    {
//        size = CGSizeMake(newSizeWidth, newSizeWidth * height / width);
//    }
//    else
//    {
//        size = CGSizeMake(newSizeHeight * width / height, newSizeHeight);
//    }
//    return [self drawImageWithSize:size];
//}
//
//- (UIImage *)drawImageWithSize: (CGSize)size
//{
//    CGSize drawSize = CGSizeMake(floor(size.width), floor(size.height));
//    UIGraphicsBeginImageContext(drawSize);
//
//    [self drawInRect:CGRectMake(0, 0, drawSize.width, drawSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}
//
//- (UIImage *)fixOrientation
//{
//
//    // No-op if the orientation is already correct
//    if (self.imageOrientation == UIImageOrientationUp)
//        return self;
//
//    // We need to calculate the proper transformation to make the image upright.
//    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//    CGAffineTransform transform = CGAffineTransformIdentity;
//
//    switch (self.imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//        default:
//            break;
//    }
//
//    switch (self.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//        default:
//            break;
//    }
//
//    // Now we draw the underlying CGImage into a new context, applying the transform
//    // calculated above.
//    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
//                                             CGImageGetBitsPerComponent(self.CGImage), 0,
//                                             CGImageGetColorSpace(self.CGImage),
//                                             CGImageGetBitmapInfo(self.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (self.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
//            break;
//
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
//            break;
//    }
//
//    // And now we just create a new UIImage from the drawing context
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
//}

@end
