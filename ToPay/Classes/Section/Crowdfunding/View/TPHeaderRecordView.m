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

@property (nonatomic, strong) UILabel * stateLab;

@property (nonatomic, strong) UILabel * timeLab;
@end

@implementation TPHeaderRecordView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _iconImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"success_icon_1"]];
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"VRT" color:TP59Color font:FONT(15)];
        [self addSubview:_nickLab];
        
        _stateLab = [YFactoryUI YLableWithText:@"已获取众筹名额" color:TP8EColor font:FONT(13)];
        [self addSubview:_stateLab];
        
        _timeLab = [YFactoryUI YLableWithText:@"2018-11-01 15:38" color:TP8EColor font:FONT(10)];
        [self addSubview:_timeLab];
    }
    return self;
}

-(void)setCroRecordModel:(TPCroRecordModel *)croRecordModel
{
    _croRecordModel = croRecordModel;
    _nickLab.text = croRecordModel.projectName;
    
    if ([croRecordModel.reservationType isEqualToString:@"0"])
    {
        _stateLab.text = @"等待项目预约结算";
        _iconImgV.image = [UIImage imageNamed:@"pending_icon_1"];
    }
        else if ([croRecordModel.reservationType isEqualToString:@"1"])
    {
        _stateLab.text = @"已获取众筹名额";
        _iconImgV.image = [UIImage imageNamed:@"success_icon_1"];
    }
        else
    {
        _stateLab.text = @"未获取众筹名额";
        _iconImgV.image = [UIImage imageNamed:@"miss_icon_1"];
    }
    
    _timeLab.text = [croRecordModel.publishAt conversionTimeStamp];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@16);
         make.top.equalTo(@17);
         make.size.equalTo(@24);
     }];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@9);
         make.top.equalTo(@13);
         make.height.equalTo(@20);
     }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
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
}


@end
