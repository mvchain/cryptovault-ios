//
//  TPPublish.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SJButtonSlider.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPPublish : UIView <SJSliderDelegate>

@property (nullable, copy) void (^sliderBlock)(SJSlider *slider);

@property (nonatomic, strong) SJButtonSlider *comSlider;


- (instancetype)initWithTransType:(TPTransactionType)transType;

@end

NS_ASSUME_NONNULL_END
