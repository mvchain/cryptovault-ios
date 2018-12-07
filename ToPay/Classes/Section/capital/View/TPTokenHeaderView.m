//
//  TPTokenHeaderView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenHeaderView.h"

@interface TPTokenHeaderView ()

@property (nonatomic, strong) UILabel *totalLab;

@property (nonatomic, strong) UIButton *chooseBtn;

@property (nonatomic, strong) UILabel *numLab;
@end

@implementation TPTokenHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        
        
        
        _totalLab = [YFactoryUI YLableWithText:@"1234567.12" color:[UIColor whiteColor] font:FONT(34)];
        [self addSubview:_totalLab];
        
        _chooseBtn = [YFactoryUI YButtonWithTitle:@"CNY" Titcolor:[UIColor whiteColor] font:FONT(12) Image:[UIImage imageNamed:@"down_icon_3"] target:self action:@selector(chooseToken)];
        _chooseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        _chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 27, 0, 0);
        [self addSubview:_chooseBtn];
        
        _numLab = [YFactoryUI YLableWithText:@"123.4567 VRT" color:[UIColor whiteColor] font:FONT(12)];
        [self addSubview:_numLab];
    }
    return self;
}

-(void)chooseToken
{
    NSLog(@"chooseToken");
}

-(void)setAssetModel:(TPAssetModel *)assetModel
{
    _assetModel = assetModel;
    
    _totalLab.text = TPString(@"%.2f",self.assetModel.ratio * self.assetModel.value);
    
    _numLab.text = TPString(@"%.4f %@",assetModel.value,assetModel.tokenName);
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_totalLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@11);
         make.top.equalTo(@16);
         make.height.equalTo(@46);
     }];
    
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.offset(-16);
         make.top.equalTo(@41);
         make.height.equalTo(@16);
     }];
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@16);
         make.top.equalTo(self.totalLab.mas_bottom).with.offset(16);
         make.height.equalTo(@16);
     }];
}

@end
