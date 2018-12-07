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



@property (nonatomic, strong) NSArray *filters;
@end

@implementation TPAddTokenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withfilterData:(NSArray *)filters
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.filters = filters;
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"BTC" color:TP59Color font:FONT(16)];
        [self addSubview:_nickLab];
        
        
        _numLab = [YFactoryUI YLableWithText:@"1234567.1234 VRT" color:TP8EColor font:FONT(12)];
        [self addSubview:_numLab];
    
        _operatingBtn = [YFactoryUI YButtonWithTitle:@"添加" Titcolor:[UIColor whiteColor] font:FONT(12) Image:nil target:self action:@selector(operatingClick:)];
        [_operatingBtn setLayer:15 WithBackColor:[UIColor colorWithHex:@"#0AA8A5"]];
        [self addSubview:_operatingBtn];
    }
    return self;
}

-(void)setClData:(CLData *)clData
{
    _clData = clData;
    
    [_iconImgV sd_setImageWithURL:[NSURL URLWithString:clData.tokenImage]];
    
    _nickLab.text = clData.tokenName;
    
    if ([clData.tokenName isEqualToString:@"VRT"] | [clData.tokenName isEqualToString:@"余额"])
    self.operatingBtn.hidden = YES;
    else
    self.operatingBtn.hidden = NO;
    
    
    
    if ([self.filters containsObject:clData.tokenName])
    {
        [_operatingBtn setTitle:@"移除" forState:UIControlStateNormal];
        _operatingBtn.selected = NO;
        _operatingBtn.backgroundColor = [UIColor colorWithHex:@"#0AA8A5"];
    }
        else
    {
        [_operatingBtn setTitle:@"添加" forState:UIControlStateNormal];
        _operatingBtn.selected = YES;
        _operatingBtn.backgroundColor = [UIColor colorWithHex:@"#E86636"];
    }

    _numLab.text = TPString(@"%@/%@",clData.tokenCnName,clData.tokenEnName);
}



-(void)operatingClick:(UIButton *)sender
{
    if (self.operatingBlock)
    {
        self.operatingBlock(sender.selected, _clData.tokenId, _clData.tokenName);
    }
    
    
    sender.selected = !sender.selected;
    if (sender.selected == NO)
    {
        [sender setTitle:@"移除" forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithHex:@"#0AA8A5"];
    }
}

-(void)setIsRemoveToken:(BOOL)isRemoveToken
{
    _isRemoveToken = isRemoveToken;
    
    self.operatingBtn.selected = YES;
    [self.operatingBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.operatingBtn.backgroundColor = [UIColor colorWithHex:@"#E86636"];
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
        make.left.equalTo(self.iconImgV.mas_right).with.offset(12);
        make.top.equalTo(@11);
        make.height.equalTo(@21);
    }];
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.offset(12);
         make.top.equalTo(self.nickLab.mas_bottom).with.offset(4);
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];    
}

@end
