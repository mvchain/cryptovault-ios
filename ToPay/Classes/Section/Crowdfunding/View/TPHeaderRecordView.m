//
//  TPHeaderRecordView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPHeaderRecordView.h"

@interface TPHeaderRecordView ()
@property (nonatomic, strong) UIImageView * iconImgV;

@property (nonatomic, strong) UILabel * nickLab;

@property (nonatomic, strong) UILabel * numLab;

@property (nonatomic, strong) UILabel * stateLab;

@property (nonatomic, strong) UILabel * timeLab;
@end

@implementation TPHeaderRecordView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"VRT" color:TP59Color font:FONT(15)];
        [self addSubview:_nickLab];
        
        _numLab = [YFactoryUI YLableWithText:@"预约购买量：20000 POT" color:TP8EColor font:FONT(10)];
        [self addSubview:_numLab];
        
        _stateLab = [YFactoryUI YLableWithText:@"已获取众筹名额" color:TP8EColor font:FONT(13)];
        [self addSubview:_stateLab];
        
        _timeLab = [YFactoryUI YLableWithText:@"2018-11-01 15:38" color:TP8EColor font:FONT(10)];
        [self addSubview:_timeLab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@12);
         make.top.equalTo(@22);
         make.size.equalTo(@16);
     }];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@9);
         make.top.equalTo(@13);
         make.height.equalTo(@20);
     }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@9);
         make.top.equalTo(self.nickLab.mas_bottom).with.equalTo(@2);
         make.height.equalTo(@14);
     }];
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.equalTo(@(-12));
         make.top.equalTo(@14);
         make.height.equalTo(@17);
     }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.stateLab);
         make.top.equalTo(self.stateLab.mas_bottom).with.equalTo(@4);
         make.height.equalTo(@14);
     }];
}


@end
