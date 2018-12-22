//
//  TPHeaderComView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPHeaderComView.h"

@interface TPHeaderComView ()
@property (nonatomic, strong) UIImageView * iconImgV;

@property (nonatomic, strong) UILabel * nickLab;

@property (nonatomic, strong) UILabel * cateLab;

@property (nonatomic, strong) UILabel * timeLab;

@property (nonatomic, strong) UIButton * participateBtn;

@property (nonatomic) TPCrowdfundStyle crowdStyle;
@end

@implementation TPHeaderComView

- (instancetype)initWithStyle:(TPCrowdfundStyle)crowdStyle
{
    self = [super init];
    if (self)
    {
        _crowdStyle = crowdStyle;
        
        _iconImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"btc_icon"]];
        [_iconImgV setLayer:5 WithBackColor:[UIColor clearColor]];
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"VRT" color:TP59Color font:FONT(16)];
        [self addSubview:_nickLab];
        
        _cateLab = [YFactoryUI YLableWithText:@"接受币种：VRT" color:TP8EColor font:FONT(13)];
        [self addSubview:_cateLab];
        
        _timeLab = [YFactoryUI YLableWithText:@"预约时间：2018-11-01 15:38" color:TP8EColor font:FONT(13)];
        [self addSubview:_timeLab];
        
        if (_crowdStyle == TPCrowdfundStyleReservation || _crowdStyle == TPCrowdfundStyleEnd)
        {
            BOOL  isCrowd = _crowdStyle == TPCrowdfundStyleReservation;
            
            _participateBtn = [YFactoryUI YButtonWithTitle:isCrowd ? @"立即预约": @"已结束" Titcolor:isCrowd ? [UIColor whiteColor]:[UIColor colorWithHex:@"#D5D7E6"] font:FONT(13) Image:nil target:self action:@selector(participateClick)];
            [_participateBtn setLayer:18 WithBackColor:isCrowd ? TPMainColor:[UIColor colorWithHex:@"#ECEEF1"]];
            [self addSubview:_participateBtn];
            if (_crowdStyle == TPCrowdfundStyleEnd) {
                _participateBtn.userInteractionEnabled = NO;
            }
            
        }
        
    }
    return self;
}

-(void)participateClick
{
    if(self.participateBlock)
    {
        self.participateBlock();
    }
}

-(void)setCroModel:(TPCrowdfundingModel *)croModel
{
    _croModel = croModel;

    NSLog(@"%@",croModel.projectImage);
    
    [_iconImgV setIconHeader:croModel.projectImage placeholderImage:@"default_project"];
    
    _cateLab.text = TPString(@"接受币种:%@",croModel.baseTokenName);
    _nickLab.text = croModel.projectName;
    _timeLab.text = TPString(@"预约时间:%@",[croModel.startedAt conversionTimeStamp]);
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@16);
         make.top.equalTo(@23);
         make.size.equalTo(@42);
     }];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@12);
         make.top.equalTo(@12);
         make.height.equalTo(@21);
     }];
    
    [self.cateLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@12);
         make.top.equalTo(self.nickLab.mas_bottom).with.equalTo(@3);
         make.height.equalTo(@17);
     }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.iconImgV.mas_right).with.equalTo(@12);
         make.top.equalTo(self.cateLab.mas_bottom).with.equalTo(@6);
         make.height.equalTo(@17);
     }];
    
    if (_crowdStyle != TPCrowdfundStyleComingSoon)
    [self.participateBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.offset(-16);
         make.top.equalTo(@12);
         make.height.equalTo(@36);
         make.width.equalTo(@88);
     }];
}

@end
