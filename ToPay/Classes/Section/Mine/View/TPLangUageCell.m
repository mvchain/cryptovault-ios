//
//  TPLangUageCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPLangUageCell.h"

@implementation TPLangUageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone; 
        
        _langLab = [YFactoryUI YLableWithText:@"" color:[UIColor colorWithHex:@"#7A7A7C"] font:FONT(14)];
        [self addSubview:_langLab];
        
        _selctImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"disselected_icon"]];
//        _selctImgV.backgroundColor = YRandomColor;
        [self addSubview:_selctImgV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_langLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@17);
         make.centerY.equalTo(self);
         make.height.equalTo(@19);
     }];
    
    
    
    [_selctImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(@(-19));
         make.centerY.equalTo(self);
         make.size.equalTo(@18);
     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
