//
//  TPMeHeaderView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPMeHeaderView.h"
#import "TPUserInfo.h"

@interface TPMeHeaderView ()
@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *mobLab;
@property (nonatomic, strong) UILabel *privateKeyLabel;
@end

@implementation TPMeHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = TPF6Color;//[UIColor redColor];
        _backImgV = [YFactoryUI YImageViewWithimage:  [UIImage imageNamed:iPhoneX ? @"X_homepage_allbg": @"X_homepage_allbg"]];
        [self addSubview:_backImgV];
        
        _iconImgV = [YFactoryUI YImageViewWithimage:nil];
        [_iconImgV setLayer:56/2 WithBackColor:[UIColor clearColor]];
        [self addSubview:_iconImgV];
        
        _nickLab = [YFactoryUI YLableWithText:@"" color:[UIColor whiteColor] font:FONT(17)];
        [self addSubview:_nickLab];
        
        _mobLab = [YFactoryUI YLableWithText:@"" color:[UIColor whiteColor] font:FONT(13)];
        
        [self addSubview:_mobLab];
        _privateKeyLabel = [YFactoryUI YLableWithText:@"" color:[UIColor whiteColor] font:FONT(13)];
        _privateKeyLabel.numberOfLines = 2;
        
        
        [self addSubview:_privateKeyLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) wsf = self ;
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    TPUserInfo *userInfo = (TPUserInfo *)[listCache objectForKey:TPUserInfoKey];
    if (userInfo)
    {
        NSLog(@"headImage:%@",userInfo.headImage);
        [self.iconImgV setRectHeader:userInfo.headImage];
        self.nickLab.text = userInfo.nickname;
        self.mobLab.text = TPString(@"手机号：%@",userInfo.username);
        TPLoginModel *loginM = [TPLoginUtil userInfo];
        [self.privateKeyLabel setText:TPString(@"公钥：%@",loginM.publicKey)];
        
    }
    [_backImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.equalTo(@0);
        make.width.equalTo(self);
        make.height.equalTo(@(156 + STATUS_BAR_HEIGHT));
    }];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@32);
        make.top.equalTo(@(24 + STATUS_BAR_HEIGHT ));
        make.size.equalTo(@56);
    }];
    [_nickLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.leading.equalTo(wsf.iconImgV.mas_trailing).with.offset(20);
        make.top.equalTo(self.iconImgV.mas_top).with.offset(3);
        make.height.equalTo(@22);
    }];
    
    [_mobLab mas_makeConstraints:^(MASConstraintMaker *make) {
         make.leading.equalTo(wsf.iconImgV.mas_trailing).with.offset(20);
        make.top.equalTo(self.nickLab.mas_bottom).with.offset(10);
        make.height.equalTo(@17);
    }];
    [_privateKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(wsf.iconImgV.mas_trailing).with.offset(20);
        make.top.equalTo(self.mobLab.mas_bottom).with.offset(10);
        make.trailing.equalTo(@(-20));
        
        make.height.equalTo(@40);
    }];
    
}
@end
