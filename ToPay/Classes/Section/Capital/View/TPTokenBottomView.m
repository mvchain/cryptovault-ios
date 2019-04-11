//
//  TPTokenBottomView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/19.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenBottomView.h"

@interface TPTokenBottomView ()

@property (nonatomic) TPChainStyle style;
@property (nonatomic) UIButton * takeOutBtn;
@end
@implementation TPTokenBottomView
- (instancetype)initWithStyle:(TPChainStyle)style
{
    self = [super init];
    if (self)
    {
        _style = style;
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
 
        UIButton *transferBtn = [YFactoryUI YButtonWithTitle:@"转账" Titcolor:[UIColor whiteColor] font:FONT(15) Image:nil target:self action:@selector(transferClcik)];
        [transferBtn setLayerCornerRadius:20 WithColor:[UIColor clearColor] WithBorderWidth:1];
        [transferBtn setBackgroundColor:[UIColor colorWithHex:@"#6A4AFF"]];
        [self addSubview:transferBtn];
        self.transferBtn = transferBtn;
        UIButton *receiptBtn = [YFactoryUI YButtonWithTitle:@"收款" Titcolor:[UIColor whiteColor] font:FONT(15) Image:nil target:self action:@selector(receiptClcik)];
        [receiptBtn setLayer:20 WithBackColor:[UIColor colorWithHex:@"#824EFF"]];
        [self addSubview:receiptBtn];
        self.receiptBtn = receiptBtn;
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:self.transferBtn];
        [array addObject:self.receiptBtn];
        [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:11 leadSpacing:16 tailSpacing:16];
        [array mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.equalTo(@6);
             
             make.height.equalTo(@40);
         }];
    
}


- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self.transferBtn setTitle:titleArray[0] forState:UIControlStateNormal];
    [self.receiptBtn setTitle:titleArray[1] forState:UIControlStateNormal];
}



- (void)transferClcik
{
    if (self.chainTransferBlock)
    {
        self.chainTransferBlock();
    }
}
- (void)receiptClcik
{
    if (self.chainReceiptBlock)
    {
        self.chainReceiptBlock();
    }
}
@end
