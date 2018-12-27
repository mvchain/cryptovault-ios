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

@property (nonatomic, strong) UILabel *proLab;
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
        
        _proLab = [YFactoryUI YLableWithText:@"" color:[UIColor clearColor] font:FONT(12)];
        [self addSubview:_proLab];
    }
    return self;
}

-(void)setTokenTopic:(TPTokenTopic *)tokenTopic
{
    _tokenTopic = tokenTopic;
    
    _nickLab.text = tokenTopic.tokenName;
    _timeLab.text = [tokenTopic.createdAt conversionTimeStamp];
    
    
    
    if ([tokenTopic.classify isEqualToString:@"0"] || [tokenTopic.classify isEqual:@"3"])
    {
        _iconImgV.image = [UIImage imageNamed:[tokenTopic.transactionType isEqualToString:@"1"] ? @"receive_icon": @"sent_icon"];
        if ([tokenTopic.tokenName isEqualToString:@"余额"])
        {
            [self setValueLabCenter];
            
        }
            else
        {
            [self setStatus];
        
            [_valueLab mas_updateConstraints:^(MASConstraintMaker *make)
             {
                 make.top.equalTo(@10);
             }];
        }
    }
        else if ([tokenTopic.classify isEqualToString:@"2"])
    {
        _nickLab.text = [NSString stringWithFormat:@"%@众筹",tokenTopic.orderRemark];
        _iconImgV.image = [UIImage imageNamed:@"Crowdfunding_icon_2"];
        [self setValueLabCenter];
    }
        else if ([tokenTopic.classify isEqualToString:@"1"])
    {
        _iconImgV.image = [UIImage imageNamed:@"trand_icon_2"];
        [self setValueLabCenter];
    }
    
    
    if ([tokenTopic.transactionType isEqualToString:@"1"])
    {
        _valueLab.text = TPString(@"+%.4f",[tokenTopic.value floatValue]);
    }
        else if([tokenTopic.transactionType isEqualToString:@"2"])
    {
        _valueLab.text = TPString(@"-%.4f",[tokenTopic.value floatValue]);
    }
}

-(void)setStatus
{
    [_proLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self.valueLab.mas_right);
        make.top.equalTo(self.valueLab.mas_bottom).with.offset(4);
        make.height.equalTo(@16);
    }];
    
    if ([_tokenTopic.status isEqualToString:@"0"] || [_tokenTopic.status isEqualToString:@"1"])
    {
        _proLab.textColor = TP59Color;
        _proLab.text = @"转账中";
    }
        else if ([_tokenTopic.status isEqualToString:@"2"])
    {
        _proLab.textColor = TP8EColor;
        _proLab.text = @"转账成功";
    }
        else
    {
        _proLab.textColor = [UIColor colorWithHex:@"#F33636"];
        _proLab.text = @"转账失败";
    }
}

-(void)setValueLabCenter
{
    [_valueLab mas_updateConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(self);
     }];
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
         make.height.equalTo(@22);
     }];
    
}

@end
