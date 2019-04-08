//
//  TPPublish.m
//  ToPay
//
//  Created by 蒲公英 on 2018/12/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPPublish.h"
#import "YUTextView.h"
@interface TPPublish ()

@property (nonatomic, strong) UILabel *msLab;
@property (nonatomic, strong) UILabel *currentLab;
@property (nonatomic, copy) NSString *tokenName;
@property (nonatomic, copy) NSString *currName;
@property (nonatomic) TPTransactionType transType;
@end


@implementation TPPublish

- (instancetype)initWithTransType:(TPTransactionType)transType tokenName:(nonnull NSString *)tokenName currName:(nonnull NSString *)currName
{
    self = [super init];
    if (self)
    {
        self.currName = currName;
        self.tokenName = tokenName;
        yudef_weakSelf;
        self.transType = transType;
        UILabel *msLab = [YFactoryUI YLableWithText:@"" color:TP8EColor font:FONT(13)];
        [self addSubview:msLab];
        self.msLab = msLab;
        [msLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@20);
            make.top.equalTo(@12);
            make.height.equalTo(@17);
        }];
    
        UIView * sliderView = [[UIView alloc] init];
        [sliderView setLayer:5 WithBackColor:[UIColor colorWithHex:@"#ECEEF1"]];
        [self  addSubview:sliderView];
        
        [sliderView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@16);
             make.right.equalTo(@(-16));
             make.height.equalTo(@40);
             make.top.equalTo(msLab.mas_bottom).with.offset(8);
         }];
        
        YUTextView *comSlider = [YUTextView new];
        [comSlider setPlaceHolder:@"输入价格"];
        [comSlider.xibContainer.textField bk_addObserverForKeyPath:@"text" task:^(id target) {
            NSLog(@"....");
            NSString *v = comSlider.xibContainer.textField.text;
            weakSelf.msLab.text = TPString(@"%@单价",weakSelf.transType == TPTransactionTypeTransfer ? @"买入":@"卖出");
            if (weakSelf.sliderBlock)
            {
                weakSelf.sliderBlock(comSlider);
            }
        }];
        comSlider.xibContainer.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [sliderView addSubview:comSlider];
        self.comSlider = comSlider;
        [comSlider mas_makeConstraints:^(MASConstraintMaker *make)
        {
             make.left.equalTo(@0);
             make.height.equalTo(sliderView);
             make.centerY.equalTo(sliderView);
             make.width.equalTo(sliderView.mas_width).with.offset(0);
         }];
        
        UILabel *floatLab = [YFactoryUI YLableWithText:@"" color:TP59Color font:FONT(15)];
        self.floatLab = floatLab;
        [sliderView addSubview:floatLab];
        
        [floatLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.equalTo(sliderView);
            make.right.equalTo(@(-13));
            make.height.equalTo(@20);
        }];
        UILabel *currentLab = [YFactoryUI YLableWithText:@"当前价格 100 BZTB" color:TP59Color font:FONT(13)];
        [self addSubview:currentLab];
        self.currentLab = currentLab;
        [currentLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(sliderView.mas_left);
            make.top.equalTo(sliderView.mas_bottom).with.offset(8);
            make.height.equalTo(@17);
        }];
    }
    return self;
}

-(void)setTransModel:(TPTransInfoModel *)transModel
{
    _transModel = transModel;
    CGFloat msLab_v = [QuickMaker makeFloatNumber:[transModel.price floatValue] tailNum:4];
    self.msLab.text = TPString(@"%@单价 ",self.transType == TPTransactionTypeTransfer ? @"买入":@"卖出");
    CGFloat currentLabv =  [QuickMaker makeFloatNumber:[transModel.price floatValue] tailNum:4];
    self.currentLab.text = TPString(@"当前价格 %.4f %@",currentLabv,self.tokenName);
}

#pragma mark - SJSliderDelegate

@end
