//
//  TPTransView.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/28.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTransView.h"

@interface TPTransView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView  *backView;

@property (nonatomic, strong) UILabel *descLab;

@property (nonatomic, strong) UILabel *msLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UILabel *conLab1;
@property (nonatomic, strong) UILabel *conLab2;
@property (nonatomic, strong) UIButton *forgetbtn;

@end

@implementation TPTransView

+(TPTransView *)createTransferViewStyle:(TPTransStyle)style
{
    TPTransView *transView = [[TPTransView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:style];
    return transView;
}

-(instancetype)initWithFrame:(CGRect)frame style:(TPTransStyle)style
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];

        UIButton *cancelBtn = [YFactoryUI YButtonWithTitle:@"" Titcolor:nil font:nil Image:[UIImage imageNamed:@"cancel_icon_black"] target:self action:@selector(hiddenMenuView)];
        [_backView addSubview:cancelBtn];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.equalTo(@0);
            make.size.equalTo(@44);
        }];
        
        UILabel *descLab = [YFactoryUI YLableWithText:@"确认转账" color:TP59Color font:FONT(15)];
        [_backView addSubview:descLab];
        self.descLab = descLab;
        [descLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self.backView);
            make.top.equalTo(@13);
            make.height.equalTo(@20);
        }];
        
        UIView *sepView = [UIView new];
        sepView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
        [_backView addSubview:sepView];
        
        [sepView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self.backView);
            make.top.equalTo(cancelBtn.mas_bottom);
            make.width.equalTo(@(KWidth));
            make.height.equalTo(@1);
        }];
        
        UILabel *msLab = [YFactoryUI YLableWithText:@"需支付" color:TP8EColor font:FONT(12)];
        [_backView addSubview:msLab];
        self.msLab = msLab;
        [msLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self.backView);
            make.top.equalTo(sepView.mas_bottom).with.offset(16);
            make.height.equalTo(@16);
        }];
        
        UILabel *numLab = [YFactoryUI YLableWithText:@"12.1424 BTC" color:TP59Color font:FONT(27)];
        [_backView addSubview:numLab];
        self.numLab = numLab;
        [numLab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.equalTo(self.backView);
             make.top.equalTo(msLab.mas_bottom).with.offset(4);
             make.height.equalTo(@36);
         }];
        
        NSArray *titArray;

        
        if (style == TPTransStyleReservation)
        {
            titArray = @[@"预约数量"];
        }
            else if (style == TPTransStyleTransfer)
        {
            titArray = @[@"收款地址",@"交易手续费"];
        }
            else if (style == TPTransStyleTakeOut)
        {
            titArray = @[@""];
        }
            else if (style == TPTransStyleReleaseSell)
        {
            titArray = @[@"总价",@"出售单价"];
        }
            else if  (style == TPTransStyleReleaseBuy)
        {
            titArray = @[@"购买数量",@"购买单价"];
        }
        
        
        TransTextView *transTextView;
        for (int i = 0 ; i < titArray.count; i++)
        {
            transTextView = [[TransTextView alloc] initWithTitle:titArray[i] WithCon:@""];
            [_backView addSubview:transTextView];
            
            if (i == 0) {
                self.conLab1 = transTextView.conLab;
            }else if (i == 1)
            {
                self.conLab2 = transTextView.conLab;
            }
            
            [transTextView mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.left.equalTo(@0);
                make.top.equalTo(numLab.mas_bottom).with.offset(i *  44);
                make.width.equalTo(@(KWidth));
                make.height.equalTo(style == TPTransStyleTakeOut?@10:@44);
            }];
        }
        CGFloat pasW = self.frame.size.width - 32;
        
        _pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(0, 0, pasW, 48)];
        [_backView addSubview:_pasView];
        [self bringSubviewToFront:_pasView];
        [_pasView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@(KWidth*0.5 - pasW*0.5));
            make.top.equalTo(transTextView.mas_bottom).with.offset(21);
        }];
        UILabel *forgetLab = [YFactoryUI YLableWithText:@"忘记密码?" color:TPA7Color font:FONT(12)];
        [self addSubview:forgetLab];
        [forgetLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.equalTo(self.mas_right).with.offset(-16);
            make.height.equalTo(@16);
            make.top.equalTo(self.pasView.mas_bottom).with.offset(10 + 48);
        }];
        _forgetbtn = [YFactoryUI YButtonWithTitle:@"" Titcolor:nil font:nil Image:nil target:self action:@selector(forgetButtonTap:)];
        [self addSubview:_forgetbtn];
        [_forgetbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(forgetLab.mas_centerX);
            make.centerY.equalTo(forgetLab.mas_centerY);
            make.width.equalTo(forgetLab.mas_width).with.offset(44);
            make.height.equalTo(forgetLab.mas_height).with.offset(44);
        }];
    }
    return self;
}

- (void)forgetButtonTap:(id)sender {
    if(self.pvc) {
        [self hideMenuWithAnimate:^{
             [QuickDo entoForgetPayPwd:self.pvc];
        }];
        
       
        
        
    }
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.descLab.text = title;
}

-(void)setDesc:(NSString *)desc
{
    _desc = desc;
    self.msLab.text = desc;
}

-(void)setTotal:(NSString *)Total
{
    _Total = Total;
    self.numLab.text = Total;
}

-(void)setCon1:(NSString *)con1
{
    _con1 = con1;
    self.conLab1.text = con1;
}

-(void)setCon2:(NSString *)con2
{
    _con2 = con2;
    self.conLab2.text = con2;
}

-(void)showMenuWithAlpha:(BOOL)isShow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    CGFloat menuHeight = iPhoneX ? 674 : 572;
    if (isShow)
    {
        self.backView.frame = CGRectMake(0, KHeight, KWidth, menuHeight);
    }
    
    [UIView animateWithDuration:0.25 animations:^
     {
         self.backView.frame = CGRectMake(0, isShow ? KHeight - menuHeight:KHeight, KWidth, menuHeight);
     } completion:^(BOOL finished) {
         if (!isShow)
             [self removeFromSuperview];
     }];
}
- (void)hideMenuWithAnimate:(void(^)(void))complete {
    
    [self removeFromSuperview];
    complete();
    
    
}
-(void)hiddenMenuView
{
    [self showMenuWithAlpha:NO];
}

@end


@implementation TransTextView

-(instancetype)initWithTitle:(NSString *)title WithCon:(NSString *)con
{
    if (self = [super init])
    {
        UILabel *titleLab = [YFactoryUI YLableWithText:title color:TP8EColor font:FONT(14)];
        [self addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@16);
            make.centerY.equalTo(self);
            make.height.equalTo(@19);
        }];
        
        self.conLab = [YFactoryUI YLableWithText:con color:TP8EColor font:FONT(14)];
        self.conLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.conLab];
        
        [self.conLab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(@(-16));
             make.centerY.equalTo(self);
             make.height.equalTo(@19);
             make.width.equalTo(@211);
         }];
        
        UIView *sepView = [[UIView alloc] init];
        sepView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
        [self addSubview:sepView];
        
        [sepView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.bottom.equalTo(self);
            make.width.equalTo(@(KWidth - 16*2));
            make.height.equalTo(@1);
        }];
    }
    return self;
}

@end


