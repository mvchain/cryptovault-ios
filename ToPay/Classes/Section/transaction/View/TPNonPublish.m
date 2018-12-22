//
//  TPNonPublish.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPNonPublish.h"

@implementation TPNonPublish

- (instancetype)initWithTransType:(TPTransactionType)transType
{
    self = [super init];
    if (self)
    {
        BOOL isOut = transType == TPTransactionTypeTransferOut ? YES:NO;
        
        NSArray *titleArr = @[isOut ? @"买家:":@"卖家:",TPString(@"剩余%@量:",isOut ? @"购买":@"出售"),TPString(@"%@价格:",isOut ? @"购买":@"出售")];
        UILabel *titLab;
        for (int i = 0; i < titleArr.count; i++)
        {
            titLab = [YFactoryUI YLableWithText:titleArr[i] color:TP59Color font:FONT(13)];
            [self addSubview:titLab];
            
            [titLab mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.left.equalTo(@17);
                make.top.equalTo(@(14 + i * 28));
                make.height.equalTo(@17);
            }];
            
            UILabel *conLab = [YFactoryUI YLableWithText:@"大萨达撒" color:TP59Color font:FONT(13)];
            [self addSubview:conLab];
            conLab.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.3];
            [conLab mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.right.equalTo(@(-15));
                make.top.equalTo(@(14 + i * 28));
                make.height.equalTo(@17);
            }];
        }
        
        
        UIView *sepView = [UIView new];
        sepView.backgroundColor = [UIColor colorWithHex:@"#ECEEF1"];
        [self addSubview:sepView];
        
        [sepView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(titLab.mas_bottom).with.offset(13);
            make.centerX.equalTo(self);
            make.height.equalTo(@1);
            make.width.equalTo(self).with.offset(-(16*2));
        }];
    }
    return self;
}

@end
