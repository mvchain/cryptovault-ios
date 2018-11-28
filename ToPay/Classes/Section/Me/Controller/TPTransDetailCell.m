//
//  TPTransDetailCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/27.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTransDetailCell.h"
#import "UILabel+WLAttributedString.h"
@interface TPTransDetailCell ()
//@property (nonatomic, strong) UILabel *titleLab;
//@property (nonatomic, strong) UILabel *conLab;
@end

@implementation TPTransDetailCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleLab = [YFactoryUI YLableWithText:@"金额:" color:TP59Color font:FONT(14)];
        [self addSubview:_titleLab];
        
        _conLab = [YFactoryUI YLableWithText:@"0x2051dd2bab0ae6c75dee40546e5ffa196ccc2448" color:TP59Color font:FONT(14)];
        [_conLab wl_changeLineSpaceWithTextLineSpace:5];
        _conLab.textAlignment = NSTextAlignmentRight;
        _conLab.numberOfLines = 0;

        [self addSubview:_conLab];
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@40);
        make.top.equalTo(@13);
        make.height.equalTo(@19);
    }];
    
    [_conLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(@(-40));
        make.width.equalTo(@183);
        make.top.equalTo(@12);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
