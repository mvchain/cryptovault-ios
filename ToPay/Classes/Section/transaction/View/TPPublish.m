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
@property (nonatomic, strong) UILabel *msLab;
@property (nonatomic, strong) UILabel *currentLab;

@property (nonatomic, copy) NSString *tokenName;
@property (nonatomic, copy) NSString *currName;
@property (nonatomic) TPTransactionType transType;
@end

@implementation TPPublish

- (instancetype)initWithTransType:(TPTransactionType)transType tokenName:(nonnull NSString *)tokenName currName:(nonnull NSString *)currName
{
    self = [super init];
    if (self)
    {
        self.currName = currName;
        self.tokenName = tokenName;
        
        self.transType = transType;
        UILabel *msLab = [YFactoryUI YLableWithText:@"dsadsa" color:TP8EColor font:FONT(13)];
        [self addSubview:msLab];
        self.msLab = msLab;
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
        self.currentLab = currentLab;
        [currentLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(sliderView.mas_left);
            make.top.equalTo(sliderView.mas_bottom).with.offset(8);
            make.height.equalTo(@17);
        }];
    }
    return self;
}

-(void)setTransModel:(TPTransInfoModel *)transModel
{
    _transModel = transModel;
    
    
    self.msLab.text = TPString(@"%@单价: %.4f %@",self.transType == TPTransactionTypeTransfer ? @"购买":@"出售",[transModel.price floatValue],self.currName);
    self.currentLab.text = TPString(@"当前价格 %.4f %@",[transModel.price floatValue],self.currName);
}

#pragma mark - SJSliderDelegate
-(void)sliderDidDrag:(SJSlider *)slider
{
    self.floatLab.text = TPString(@"%.2f%%",slider.value);
    self.msLab.text = TPString(@"%@单价：%.4f %@",self.transType == TPTransactionTypeTransfer ? @"购买":@"出售",[self.transModel.price floatValue] *slider.value/100 ,self.currName);
    if (self.sliderBlock)
    {
        self.sliderBlock(slider);
    }
}

@end
