//
//  TPMSCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/17.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPMSCell.h"
@interface TPMSCell ()

@property (nonatomic, strong) UILabel *lab1;

@property (nonatomic, strong) UILabel *lab2;

@property (nonatomic, strong) UILabel *lab3;

@end

@implementation TPMSCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _lab1 = [YFactoryUI YLableWithText:@"币种" color:TP8EColor font:FONT(14)];
        [self addSubview:_lab1];
        
        _lab2 = [YFactoryUI YLableWithText:@"价格" color:TP8EColor font:FONT(14)];
        [self addSubview:_lab2];
        
        _lab3 = [YFactoryUI YLableWithText:@"24H涨跌" color:TP8EColor font:FONT(14)];
        _lab3.textAlignment = NSTextAlignmentRight;
        [self addSubview:_lab3];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(self);
         make.left.equalTo(@16);
         make.height.equalTo(@19);
     }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(self);
         make.right.mas_equalTo(self.mas_right).with.equalTo(@(-16));
         make.height.equalTo(@19);
         make.width.equalTo(@72);
     }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(self);
         make.right.mas_equalTo(self.lab3.mas_left).with.equalTo(@(-20));
         make.height.equalTo(@19);
     }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
