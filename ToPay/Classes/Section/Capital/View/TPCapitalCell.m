//
//  TPCapitalCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCapitalCell.h"
#import "TPCurrencyList.h"

@interface TPCapitalCell ()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) UILabel *nickLab;

@property (nonatomic, strong) UILabel *valueLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) YYCache *listCache;
@end

@implementation TPCapitalCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _backView = [[UIView alloc] init];

        [_backView setLayer:5 WithBackColor: [UIColor whiteColor]];
        [self addSubview:_backView];
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.15].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,1);
        _backView.layer.shadowRadius = 2;
        _backView.layer.shadowOpacity = 1;
        [_iconImgV setLayer:14.5 WithBackColor:[UIColor clearColor]];
        [_backView addSubview:_iconImgV];
        _nickLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(17)];
        [_backView addSubview:_nickLab];
        _valueLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(17)];
        [_backView addSubview:_valueLab];
        _numLab = [YFactoryUI YLableWithText:@"" color:TP8EColor font:FONT(12)];
        [_backView addSubview:_numLab];
        _listCache = [YYCache cacheWithName:TPCacheName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setAssetModel:(TPAssetModel *)assetModel
{
    _assetModel = assetModel;
    self.nickLab.text = assetModel.tokenName;
    NSLog(@"法币符号%@",[USER_DEFAULT objectForKey:TPNowLegalSymbolKey]);
    self.valueLab.text = TPString(@"%@ %.2f",[USER_DEFAULT objectForKey:TPNowLegalSymbolKey],assetModel.ratio * assetModel.value);
    self.numLab.text = TPString(@"%.4f %@",assetModel.value,assetModel.tokenName);
    CLData *clData = (CLData *)[self.listCache objectForKey:assetModel.tokenId];
    [self.iconImgV  setRefreshIconHeader:clData.tokenImage placeholderImage:@"default_coin"];
}

-(void)setRatio:(CGFloat)ratio
{
    _ratio = ratio;
    self.valueLab.text = TPString(@"%@ %.2f",[USER_DEFAULT objectForKey:TPNowLegalSymbolKey],self.assetModel.ratio * self.assetModel.value /ratio);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@16);
         make.right.equalTo(self).with.offset(-16);
         make.bottom.equalTo(self).with.offset(-6);
         make.height.equalTo(@72);
    }];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@(17));
         make.centerY.equalTo(self.backView);
         make.size.equalTo(@29);
     }];

    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@13);
         make.centerY.equalTo(self.backView);
         make.height.equalTo(@21);
     }];
    [self.valueLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.backView).with.offset(-12);
         make.top.equalTo(self.backView.mas_top).with.offset(15);
         make.height.equalTo(@22);
     }];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.backView).with.offset(-12);
         make.top.equalTo(self.valueLab.mas_bottom).with.offset(4);
         make.height.equalTo(@16);
     }];
}
@end
