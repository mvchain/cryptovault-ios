//
//  TPNonPublish.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPNonPublish.h"

@interface TPNonPublish ()
@property (nonatomic, strong) NSMutableArray<UILabel *> *publishArr;
@property (nonatomic, copy) NSString *tokenName;
@property (nonatomic, copy) NSString *currName;
@end

@implementation TPNonPublish

- (instancetype)initWithTransType:(TPTransactionType)transType tokenName:(NSString *)tokenName currName:(NSString *)currName
{
    self = [super init];
    if (self)
    {
        self.currName = currName;
        self.tokenName = tokenName;
        self.publishArr = [NSMutableArray<UILabel *> array];
        BOOL isOut = transType == TPTransactionTypeTransferOut ? YES:NO;
        
        NSArray *titleArr = @[isOut ? @"买家:":@"卖家:",TPString(@"剩余%@量:",isOut ? @"购买":@"出售"),TPString(@"%@价格:",isOut ? @"购买":@"出售")];
        UILabel *titLab;
        for (int i = 0; i < titleArr.count; i++)
        {
            titLab = [YFactoryUI YLableWithText:titleArr[i] color:TP59Color font:FONT(13)];
            titLab.textAlignment = NSTextAlignmentRight;
            [self addSubview:titLab];
            
            [titLab mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.left.equalTo(@17);
                make.top.equalTo(@(14 + i * 28));
                make.height.equalTo(@17);
            }];
            
            UILabel *conLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(13)];
            [self addSubview:conLab];
            [self.publishArr addObject:conLab];
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

-(void)setTransModel:(TPTransactionModel *)transModel
{
    _transModel = transModel;
    self.publishArr[0].text = transModel.nickname;
    CGFloat limit = [QuickMaker makeFloatNumber:[transModel.limitValue floatValue] tailNum:4];
    CGFloat price = [QuickMaker makeFloatNumber:[transModel.price floatValue] tailNum:4];
    self.publishArr[1].text = TPString(@"%.4f %@",limit,self.tokenName);
    self.publishArr[2].text = TPString(@"%.4f %@",price,@"BZTB");
}


@end
