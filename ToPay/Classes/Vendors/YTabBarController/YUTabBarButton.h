//
//  YUTabBarButton.h
//  YiU
//
//  Created by 蒲公英&守候 on 2018/3/31.
//  Copyright © 2018年 蒲公英&守候. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUBadgeValue.h"

@interface YUTabBarButton : UIView

/** UIImageView */
@property (nonatomic, strong) UIImageView *imageView;
/** Title */
@property (nonatomic, strong) UILabel *title;
/** badgeValue */
@property (nonatomic, strong) YUBadgeValue *badgeValue;
/** type */
@property (nonatomic, assign) YUConfigTypeLayout typeLayout;

@end
