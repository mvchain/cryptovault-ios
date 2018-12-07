//
//  UIImageView+YUExtension.m
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/18.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import "UIImageView+YUExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YUExtension.h"
@implementation UIImageView (YUExtension)

-(void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}

-(void)setCircleHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage circleImage:@"Default avatar_icon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;
        
        self.image = [image circleImage];
    }];
}

-(void)setRectHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:@"Default avatar_icon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
