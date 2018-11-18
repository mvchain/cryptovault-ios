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
        
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"项目名称众筹" color:TP59Color font:FONT(15)];
        [self addSubview:_nickLab];
        
        _timeLab = [YFactoryUI YLableWithText:@"2018-10-21 10:24:45" color:TP59Color font:FONT(12)];
        [self addSubview:_timeLab];
        
        _valueLab = [YFactoryUI YLableWithText:@"+123.4567" color:TP8EColor font:FONT(17)];
        [self addSubview:_valueLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
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
