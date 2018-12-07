//
//  TPTokenCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenCell.h"

@interface TPTokenCell ()

@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) UILabel *nickLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *valueLab;
@end

@implementation TPTokenCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        [self addSubview:_iconImgV];

        _nickLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(15)];
        [self addSubview:_nickLab];

        _timeLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(12)];
        [self addSubview:_timeLab];

        _valueLab = [YFactoryUI YLableWithText:@"" color:TP8EColor font:FONT(17)];
        [self addSubview:_valueLab];
    }
    return self;
}

-(void)setTokenTopic:(TPTokenTopic *)tokenTopic
{
    _tokenTopic = tokenTopic;
    
    if ([tokenTopic.classify isEqualToString:@"0"] || [tokenTopic.classify isEqual:@"3"])
    {
        if ([tokenTopic.transactionType isEqualToString:@"1"])
        {
            _iconImgV.image = [UIImage imageNamed:@"receive_icon"];
        }
        if ([tokenTopic.transactionType isEqualToString:@"2"])
        {
            _iconImgV.image = [UIImage imageNamed:@"sent_icon"];
        }
    }
        else if ([tokenTopic.classify isEqualToString:@"2"])
    {
        _iconImgV.image = [UIImage imageNamed:@"Crowdfunding_icon_2"];
    }
        else if ([tokenTopic.classify isEqualToString:@"1"])
    {
        _iconImgV.image = [UIImage imageNamed:@"trand_icon_2"];
    }
    _nickLab.text = tokenTopic.tokenName;
    
    _timeLab.text = [tokenTopic.createdAt conversionTimeStamp];
    
    _valueLab.text = tokenTopic.value;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@16);
         make.centerY.equalTo(self);
         make.size.equalTo(@24);
     }];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@10);
         make.top.equalTo(@12);
         make.height.equalTo(@20);
     }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.nickLab);
         make.top.equalTo(self.nickLab.mas_bottom).with.offset(6);
         make.height.equalTo(@16);
     }];
    
    [self.valueLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.offset(-16);
         make.centerY.equalTo(self);
         make.height.equalTo(@22);
     }];
    
}

@end
