//
//  TPCapitalHeaderView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCapitalHeaderView.h"
#import "TPExchangeRate.h"
@interface TPCapitalHeaderView ()
@property (nonatomic, strong) UILabel *totalLab;

@property (nonatomic, strong) UIButton *chooseBtn;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UIImageView *bgImgV;
@end

@implementation TPCapitalHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _bgImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"X_homepage_bg"]];
        [self addSubview:_bgImgV];
        _totalLab = [YFactoryUI YLableWithText:@"总资产" color:[UIColor whiteColor] font:FONT(14)];
        [self addSubview:_totalLab];
        _chooseBtn = [YFactoryUI YButtonWithTitle:@"" Titcolor:[UIColor whiteColor] font:FONT(12) Image:[UIImage imageNamed:@"down_icon_3"] target:self action:@selector(chooseToken)];
        _chooseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        _chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 61, 0, 0);
        [self addSubview:_chooseBtn];
        _numLab = [YFactoryUI YLableWithText:@"" color:[UIColor whiteColor] font:FONT(36)];
        [self addSubview:_numLab];
        dispatch_queue_t queen = dispatch_get_global_queue(0, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), queen, ^
       {
           dispatch_sync(dispatch_get_main_queue(), ^
             {
                 if ([USER_DEFAULT objectForKey:TPNowLegalNameKey])
                 {
                     NSString *name = [USER_DEFAULT objectForKey:TPNowLegalNameKey];
                     name = [name substringFromIndex:1];
                     [self.chooseBtn setTitle:name forState:UIControlStateNormal];
                 }
                    else
                 {
                     YYCache *listCache = [YYCache cacheWithName:TPCacheName];
                     NSArray <TPExchangeRate *>*listArr = (NSArray<TPExchangeRate *> *)[listCache objectForKey:TPLegalCurrencyListKey];
                     NSString *name = listArr[0].name;
                     name = [name substringFromIndex:1];
                     [self.chooseBtn setTitle:name forState:UIControlStateNormal];
                 }
             });
       });
        _checkButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButton setBackgroundImage:[UIImage imageNamed:@"home_check-in_img"] forState:UIControlStateNormal];
        [_checkButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
        _checkButton.hidden = YES;
        
        [self addSubview:_checkButton];
        
        [self initLayt];
    }
    return self;
}
- (void)check :(id)sender{
    // 签到
    if(_checkTap){
        _checkTap();
    }
}
- (void)initLayt{
    [_bgImgV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(self.mas_height).with.offset(-6);
     }];
    [_totalLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self);
         make.top.equalTo(@12);
         make.height.equalTo(@15);
     }];
    
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self);
         make.top.equalTo(self.totalLab.mas_bottom).with.offset(11);
         make.height.equalTo(@19);
         make.width.equalTo(@100);
     }];
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self);
         make.top.equalTo(self.chooseBtn.mas_bottom).with.offset(1);
         make.height.equalTo(@48);
     }];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@77);
        make.height.equalTo(@36);
        make.trailing.equalTo(self.mas_trailing);
        make.top.equalTo(self.mas_top).with.offset(20);
    }];
}
- (void)setTotal:(NSString *)total
{
    _total = total;
    _numLab.text = TPString(@"%.2f",[total floatValue]);
}

- (void)setRatio:(CGFloat)ratio
{
    _ratio = ratio;
    _numLab.text = TPString(@"%.2f",[_total floatValue] / ratio);
}

- (void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
    NSString *name = [_nickName substringFromIndex:1];
    [_chooseBtn setTitle:name forState:UIControlStateNormal];
}

- (void)chooseToken
{
//    NSLog(@"选择token");
    if (self.chooseCurrencyBlock) {
        self.chooseCurrencyBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
