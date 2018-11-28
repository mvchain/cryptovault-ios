//
//  TPAddTokenCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPAddTokenCell.h"

@interface TPAddTokenCell ()
@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) UILabel *nickLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) UIButton *operatingBtn;
@end

@implementation TPAddTokenCell

- (void)awakeFromNib {
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
        
        _nickLab = [YFactoryUI YLableWithText:@"BTC" color:TP59Color font:FONT(16)];
        [self addSubview:_nickLab];
        
        
        _numLab = [YFactoryUI YLableWithText:@"1234567.1234 VRT" color:TP59Color font:FONT(14)];
        [self addSubview:_numLab];
        
        _moneyLab = [YFactoryUI YLableWithText:@"￥ 123.4567" color:TP59Color font:FONT(12)];
        [self addSubview:_moneyLab];
    
        _operatingBtn = [YFactoryUI YButtonWithTitle:@"添加" Titcolor:[UIColor whiteColor] font:FONT(12) Image:nil target:self action:@selector(operatingClick)];
        [_operatingBtn setLayer:15 WithBackColor:[UIColor colorWithHex:@"#0AA8A5"]];
        [self addSubview:_operatingBtn];
    }
    return self;
}

-(void)operatingClick
{
    NSLog(@"操作事件");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(self);
        make.size.equalTo(@28);
    }];
    
    [_nickLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_iconImgV.mas_right).with.offset(12);
        make.centerY.equalTo(self);
        make.height.equalTo(@21);
    }];
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.offset(-101);
         make.top.equalTo(@13);
         make.height.equalTo(@19);
     }];
    
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self).with.offset(-101);
        make.top.equalTo(self.numLab.mas_bottom).with.offset(4);
        make.height.equalTo(@16);
    }];
    
    [_operatingBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(@(-12));
        make.centerY.equalTo(self);
        make.width.equalTo(@73);
        make.height.equalTo(@30);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
