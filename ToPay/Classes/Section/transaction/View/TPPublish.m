//
//  TPPublish.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPPublish.h"

@interface TPPublish ()
@property (nonatomic, strong) UILabel *floatLab;
@end

@implementation TPPublish

- (instancetype)initWithTransType:(TPTransactionType)transType
{
    self = [super init];
    if (self)
    {

        UILabel *msLab = [YFactoryUI YLableWithText:@"dsadsa" color:TP8EColor font:FONT(13)];
        [self addSubview:msLab];
        [msLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@20);
            make.top.equalTo(@12);
            make.height.equalTo(@17);
        }];
    
        UIView * sliderView = [[UIView alloc] init];
        [sliderView setLayer:5 WithBackColor:[UIColor colorWithHex:@"#ECEEF1"]];
        [self  addSubview:sliderView];
        
        [sliderView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@16);
             make.right.equalTo(@(-14));
             make.height.equalTo(@66);
             make.top.equalTo(msLab.mas_bottom).with.offset(8);
         }];
        
        
        SJButtonSlider *comSlider = [SJButtonSlider new];
        comSlider.rightText = @"＋";
        comSlider.leftText = @"－";

        [comSlider.slider setThumbCornerRadius:8 size:CGSizeMake(16, 16) thumbBackgroundColor:[UIColor whiteColor]];
        comSlider.slider.trackImageView.backgroundColor = TPC1Color;
        comSlider.slider.traceImageView.backgroundColor = TP59Color;
        comSlider.slider.delegate = self;
        [sliderView addSubview:comSlider];
        self.comSlider = comSlider;
        [comSlider mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@20);
             make.height.equalTo(@20);
             make.centerY.equalTo(sliderView);
             make.width.equalTo(sliderView.mas_width).with.offset(-100);
         }];
        
        UILabel *floatLab = [YFactoryUI YLableWithText:@"100.00%" color:TP59Color font:FONT(15)];
        self.floatLab = floatLab;
        [sliderView addSubview:floatLab];
        
        [floatLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.equalTo(sliderView);
            make.right.equalTo(@(-13));
            make.height.equalTo(@20);
        }];
    
        UILabel *currentLab = [YFactoryUI YLableWithText:@"当前价格 100 VRT" color:TP59Color font:FONT(13)];
        [self addSubview:currentLab];

        [currentLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(sliderView.mas_left);
            make.top.equalTo(sliderView.mas_bottom).with.offset(8);
            make.height.equalTo(@17);
        }];
    }
    return self;
}

#pragma mark - SJSliderDelegate
-(void)sliderDidDrag:(SJSlider *)slider
{
    self.floatLab.text = TPString(@"%.2f%%",slider.value * 100);
    if (self.sliderBlock)
    {
        self.sliderBlock(slider);
    }
}

@end
