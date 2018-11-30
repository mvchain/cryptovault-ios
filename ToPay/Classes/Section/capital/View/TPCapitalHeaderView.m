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


@end

@implementation TPCapitalHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
//        self.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.2];
        
        _totalLab = [YFactoryUI YLableWithText:@"总资产" color:[UIColor whiteColor] font:FONT(12)];
        [self addSubview:_totalLab];
        
        _chooseBtn = [YFactoryUI YButtonWithTitle:@"CNY" Titcolor:[UIColor whiteColor] font:FONT(14) Image:nil target:self action:@selector(chooseToken)];
        [self addSubview:_chooseBtn];
        
        _numLab = [YFactoryUI YLableWithText:@"123.4567" color:[UIColor whiteColor] font:FONT(36)];
        [self addSubview:_numLab];
    }
    return self;
}

-(void)setTotal:(NSString *)total
{
    _total = total;
    _numLab.text = TPString(@"%.4f",[total floatValue]);
}

-(void)setRatio:(CGFloat)ratio
{
    _ratio = ratio;
    
    _numLab.text = TPString(@"%.4f",[_total floatValue] / ratio);
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
    [TPLoginUtil setRequestTokenBase];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
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
