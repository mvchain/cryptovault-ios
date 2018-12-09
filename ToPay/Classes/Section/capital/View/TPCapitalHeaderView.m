//
//  TPCapitalHeaderView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCapitalHeaderView.h"

@interface TPCapitalHeaderView ()
@property (nonatomic, strong) UILabel *totalLab;

@property (nonatomic, strong) UIButton *chooseBtn;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UIImageView *bgImgV;

@end

@implementation TPCapitalHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _bgImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"X_homepage_bg"]];
        [self addSubview:_bgImgV];
        
        
        _totalLab = [YFactoryUI YLableWithText:@"总资产" color:[UIColor whiteColor] font:FONT(12)];
        [self addSubview:_totalLab];
        
        _chooseBtn = [YFactoryUI YButtonWithTitle:@"CNY" Titcolor:[UIColor whiteColor] font:FONT(14) Image:[UIImage imageNamed:@"down_icon_3"] target:self action:@selector(chooseToken)];
        _chooseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        _chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 32, 0, 0);
        [self addSubview:_chooseBtn];
        
        _numLab = [YFactoryUI YLableWithText:@"123.4567" color:[UIColor whiteColor] font:FONT(36)];
        [self addSubview:_numLab];
    }
    return self;
}

-(void)setTotal:(NSString *)total
{
    _total = total;
    _numLab.text = TPString(@"%.2f",[total floatValue]);
}

-(void)setRatio:(CGFloat)ratio
{
    _ratio = ratio;
    
    _numLab.text = TPString(@"%.2f",[_total floatValue] / ratio);
}

-(void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
    
    [_chooseBtn setTitle:nickName forState:UIControlStateNormal];
}

-(void)chooseToken
{
    NSLog(@"选择token");
    if (self.chooseCurrencyBlock) {
        self.chooseCurrencyBlock();
    }
//    [TPLoginUtil setRequestTokenBase];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_bgImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.mas_height);
    }];
    
    [_totalLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self);
        make.top.equalTo(@12);
        make.height.equalTo(@15);
    }];
    
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self);
        make.top.equalTo(self.totalLab.mas_bottom).with.offset(11);
        make.height.equalTo(@19);
    }];
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self);
        make.top.equalTo(self.chooseBtn.mas_bottom).with.offset(1);
        make.height.equalTo(@48);
    }];
}

@end
