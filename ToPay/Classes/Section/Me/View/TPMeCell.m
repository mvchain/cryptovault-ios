//
//  TPMeCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPMeCell.h"
@interface TPMeCell ()

@end
@implementation TPMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [self addSubview:_iconImgV];
     
        _descLab = [YFactoryUI YLableWithText:@"语言" color:TP59Color font:FONT(14)];
        [self addSubview:_descLab];
        
        _arrowImgV = [YFactoryUI YImageViewWithimage:nil];
        _arrowImgV.backgroundColor = YRandomColor;
        [self addSubview:_arrowImgV];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(@26);
        make.centerY.equalTo(self);
        make.size.equalTo(@20);
    }];
    
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.iconImgV.mas_right).with.offset(20);
        make.centerY.equalTo(self);
        make.height.equalTo(@19);
    }];
    
    [_arrowImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(@(-26));
        make.centerY.equalTo(self);
        make.size.equalTo(@12);
    }];
}

@end
