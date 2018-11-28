//
//  TPUSDTCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPUSDTCell.h"

@interface TPUSDTCell ()
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *limitLab;
@property (nonatomic, strong) UILabel *priceLab;
@end

@implementation TPUSDTCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"阿三" color:TP59Color font:FONT(14)];
        [self addSubview:_nickLab];
        
        _limitLab = [YFactoryUI YLableWithText:@"购买限额:15000" color:TP8EColor font:FONT(12)];
        [self addSubview:_limitLab];
        
        _priceLab = [YFactoryUI YLableWithText:@"1234567.1234" color:TP59Color font:FONT(16)];
        [self addSubview:_priceLab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@16);
        make.centerY.equalTo(self);
        make.size.equalTo(@32);
    }];
    
    [_nickLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.iconImgV.mas_right).with.offset(9);
        make.top.equalTo(@13);
        make.height.equalTo(@19);
    }];
    
    [_limitLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.offset(9);
         make.top.equalTo(self.nickLab.mas_bottom).with.offset(4);
         make.height.equalTo(@16);
     }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self.mas_right).with.offset(-16);
        make.centerY.equalTo(self);
        make.height.equalTo(@21);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
