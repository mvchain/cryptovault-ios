//
//  TPVRTCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPVRTCell.h"

@interface TPVRTCell ()
@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) UILabel *nickLab;

@property (nonatomic, strong) UILabel *VRTpriceLab;

@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, strong) UILabel *floatLab;


@property (nonatomic, copy) NSString *currName;
@end

@implementation TPVRTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier currName:(NSString *)currName
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.currName = currName;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"btc_icon"]];
//        _iconImgV.backgroundColor = YRandomColor;
        [_iconImgV setLayer:14 WithBackColor:[ UIColor clearColor]];
        
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"BTC" color:TP59Color font:FONT(16)];
        [self addSubview:_nickLab];
        
        _VRTpriceLab = [YFactoryUI YLableWithText:@"1234567.1234 VRT" color:TP59Color font:FONT(14)];
        [self addSubview:_VRTpriceLab];
        
        _priceLab = [YFactoryUI YLableWithText:@"1234.567 VRT" color:TP8EColor font:FONT(12)];
        [self addSubview:_priceLab];
        
        _floatLab = [YFactoryUI YLableWithText:@"+100.5%" color:[UIColor whiteColor] font:FONT(12)];
        _floatLab.backgroundColor = [UIColor colorWithHex:@"#E86636"];
        _floatLab.layer.cornerRadius = 5;
        _floatLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_floatLab];
    }
    return  self;
}

-(void)setVRTModel:(TPVRTModel *)VRTModel
{
    _VRTModel = VRTModel;
    
    [_iconImgV setIconHeader:VRTModel.tokenImage placeholderImage:@"default_coin"];
    
    _nickLab.text = VRTModel.tokenName;

    _VRTpriceLab.text = TPString(@"%.4f %@",[VRTModel.ratio floatValue],self.currName);
    
    _priceLab.text =  TPString(@"%@ %.2f",[USER_DEFAULT objectForKey:TPNowLegalSymbolKey],[VRTModel.ratio floatValue] / [[USER_DEFAULT objectForKey:TPNowLegalCurrencyKey] floatValue]);
    
    _floatLab.text = TPString(@"%.2f%%",[VRTModel.increase floatValue]);
    
    if ([VRTModel.transactionStatus isEqualToString:@"0"])
    {
        _floatLab.backgroundColor = [UIColor colorWithHex:@"#BDBDBF"];
        _floatLab.textColor = TP8EColor;
        _floatLab.text = @"不可交易";
    }
    
}

-(NSString *)getTokenName:(NSString *)tokenName WithPair:(NSString *)pair
{
    //match string
    NSRange range = [pair rangeOfString:tokenName];
    
    NSRange newRange = NSMakeRange(0,pair.length - range.length-1);
    //Intercept Range of strings
    return [pair substringWithRange:newRange];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(self);
        make.left.equalTo(@16);
        make.size.equalTo(@28);
    }];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(self);
         make.left.mas_equalTo(self.iconImgV.mas_right).with.equalTo(@12);
         make.height.equalTo(@21);
     }];
    
    [self.floatLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(self.mas_right).with.equalTo(@(-16));
        make.height.equalTo(@28);
        make.width.equalTo(@72);
    }];
    
    [self.VRTpriceLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@13);
         make.right.mas_equalTo(self.floatLab.mas_left).with.equalTo(@(-20));
         make.height.equalTo(@19);
     }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.floatLab.mas_left).with.equalTo(@(-20));
        make.top.mas_equalTo(self.VRTpriceLab.mas_bottom).with.equalTo(@4);
        make.height.equalTo(@16);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
