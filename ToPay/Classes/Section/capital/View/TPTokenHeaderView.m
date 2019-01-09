//
//  TPTokenHeaderView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenHeaderView.h"
#import "TPExchangeRate.h"
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
        
        _totalLab = [YFactoryUI YLableWithText:@"" color:[UIColor whiteColor] font:FONT(34)];
        [self addSubview:_totalLab];
        NSString *str = [QuickGet getLegalCurrency];
        
 
        _chooseBtn = [YFactoryUI YButtonWithTitle:str Titcolor:[UIColor whiteColor] font:FONT(12) Image:nil target:self action:@selector(chooseToken)];
        [self addSubview:_chooseBtn];
        
        _numLab = [YFactoryUI YLableWithText:@"" color:[UIColor whiteColor] font:FONT(12)];
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
         make.left.equalTo(@24);
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
         make.left.equalTo(self.totalLab);
         make.top.equalTo(self.totalLab.mas_bottom).with.offset(2);
         make.height.equalTo(@16);
     }];
}

@end
