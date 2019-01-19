//
//  TPComTextView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPComTextView.h"

@implementation TPComTextView

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc
{
    self = [super init];
    if (self)
    {
        _comTitleLabel = [YFactoryUI YLableWithText:title color:TPA7Color font:FONT(13)];
        [self addSubview:_comTitleLabel];
        
        
        _comTextField = [YFactoryUI YTextFieldWithPlaceholder:[NSString stringWithFormat:@"%@",desc] color:TP8EColor font:FONT(15) secureTextEntry:YES delegate:nil];
        _comTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _comTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _comTextField.leftView.userInteractionEnabled = NO;
//        _comTextField.clearButtonMode = UITextFieldViewModeAlways;
        _comTextField.leftViewMode = UITextFieldViewModeAlways;
        [_comTextField setLayer:5 WithBackColor:TPF6Color];
        [self addSubview:_comTextField];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.comTitleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@0);
        make.left.equalTo(@16);
        make.height.equalTo(@17);
    }];
    
    [self.comTextField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.comTitleLabel);
        make.top.equalTo(self.comTitleLabel.mas_bottom).with.offset(10);
        make.width.equalTo(@323);
        make.height.equalTo(@44);
    }];
}

@end
