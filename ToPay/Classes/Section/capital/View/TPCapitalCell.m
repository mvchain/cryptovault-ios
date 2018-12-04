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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _backView = [[UIView alloc] init];

        [_backView setLayer:5 WithBackColor: [UIColor whiteColor]];
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.15].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,3);
        _backView.layer.shadowRadius = 6;
        _backView.layer.shadowOpacity = 1;
        [self addSubview:_backView];
        
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        _iconImgV.backgroundColor = YRandomColor;
        [_backView addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"BTC" color:TP59Color font:FONT(17)];
        [_backView addSubview:_nickLab];
        
        _valueLab = [YFactoryUI YLableWithText:@"￥ 1234567.12" color:TP59Color font:FONT(17)];
        [_backView addSubview:_valueLab];
        
        _numLab = [YFactoryUI YLableWithText:@"123.4567" color:TP8EColor font:FONT(12)];
        [_backView addSubview:_numLab];
        
        
        _listCache = [YYCache cacheWithName:TPCacheName];
        
//       TPCurrencyList *currencyList = (TPCurrencyList *)[listCache objectForKey:TPCurrencyListKey];
//        NSLog(@"%@",currencyList);
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
    self.valueLab.text = TPString(@"%.2f",assetModel.ratio * assetModel.value);
    self.numLab.text = TPString(@"%.4f",assetModel.value);
    
    
   CLData *clData = (CLData *)[self.listCache objectForKey:assetModel.tokenId];
//    NSLog(@"tokenImage:%@",clData.tokenImage);
    
    [self.iconImgV  sd_setImageWithURL:[NSURL URLWithString:clData.tokenImage]];
//    assetModel.ratio * assetModel.value / 0.1492537313432836
}

-(void)setRatio:(CGFloat)ratio
{
    _ratio = ratio;
    
    self.valueLab.text = TPString(@"%.2f",self.assetModel.ratio * self.assetModel.value /ratio);
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@25);
         make.right.equalTo(self).with.offset(-16);
         make.bottom.equalTo(self).with.offset(-6);
         make.height.equalTo(@72);
    }];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@(-8));
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
