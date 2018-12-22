//
//  TPDetailTitleView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPDetailTitleView.h"
//#import ""
@implementation TPDetailTitleView

- (instancetype)initWithTextAlignment:(NSTextAlignment)textAlignment
{
    self = [super init];
    if (self)
    {
        
        _timeLab = [YFactoryUI YLableWithText:@"" color:TP8EColor font:FONT(12)];
        _timeLab.textAlignment = textAlignment;
        [self addSubview:_timeLab];
        
        _conLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(12)];
        _conLab.textAlignment = textAlignment;
        [self addSubview:_conLab];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
 
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.top.equalTo(@11);
         make.width.equalTo(self);
         make.height.equalTo(@16);
     }];
    
    [self.conLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(self.timeLab.mas_bottom).with.offset(5);
        make.width.equalTo(self);
        make.height.equalTo(@16);
    }];
}

@end
