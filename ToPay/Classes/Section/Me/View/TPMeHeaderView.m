//
//  TPMeHeaderView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPMeHeaderView.h"

@interface TPMeHeaderView ()
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *mobLab;

@end

@implementation TPMeHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = YRandomColor;
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"LCF666" color:[UIColor whiteColor] font:FONT(17)];
        [self addSubview:_nickLab];
        
        _mobLab = [YFactoryUI YLableWithText:@"手机号：12345678901" color:[UIColor whiteColor] font:FONT(13)];
        [self addSubview:_mobLab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self);
        make.top.equalTo(@32);
        make.size.equalTo(@64);
    }];
    
    [_nickLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImgV.mas_bottom).with.offset(10);
        make.height.equalTo(@22);
    }];
    
    [_mobLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nickLab.mas_bottom).with.offset(4);
        make.height.equalTo(@17);
    }];
}

@end
