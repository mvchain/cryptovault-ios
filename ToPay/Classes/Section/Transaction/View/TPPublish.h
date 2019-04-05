//
//  TPPublish.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTransInfoModel.h"
#import "SJButtonSlider.h"
#import "YUTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPPublish : UIView <SJSliderDelegate>

@property (nullable, copy) void (^sliderBlock)(YUTextView *slider);

@property (nonatomic, strong) YUTextView *comSlider;

@property (nonatomic, strong) TPTransInfoModel *transModel;
@property (nonatomic, strong) UILabel *floatLab;
- (instancetype)initWithTransType:(TPTransactionType)transType tokenName:(NSString *)tokenName currName:(NSString *)currName;

@end

NS_ASSUME_NONNULL_END
