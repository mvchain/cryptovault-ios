//
//  TPSellViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/26.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPSellViewController.h"
#import "TPComTextView.h"
#import "TPBuyRecordViewController.h"
#import "SJButtonSlider.h"
#import "TPTransInfoModel.h"
#import "TPTransView.h"

#import "TPPublish.h"
#import "TPNonPublish.h"


@interface TPSellViewController ()<SJSliderDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSMutableArray <UILabel *> *sellLabs;
@property (nonatomic, strong) TPNonPublish * nonPublish;
@property (nonatomic, strong) TPPublish * publishView;
@property (nonatomic, strong) UIButton * reservationBtn;
@property (nonatomic, strong) UILabel * conLab;
@property (nonatomic, strong) UILabel * tsLab;
@property (nonatomic, strong) TPComTextView *comText;

@property (nonatomic, strong) TPTransInfoModel *transInfo;

@property (nonatomic) TPTransactionType transType;
@property (nonatomic, copy)   NSString *pairId;
@property (nonatomic, copy)  NSString   * tokenName;
@property (nonatomic) BOOL isPublish;
@property (nonatomic) CGFloat currentPrice;
@end

@implementation TPSellViewController

- (instancetype)initWithPairId:(NSString *)pairId WithTransType:(TPTransactionType)transType publish:(BOOL)isPublish
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _pairId = pairId;
        _transType = transType;
        _isPublish = isPublish;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sellLabs = [NSMutableArray<UILabel *> array];
    self.currentPrice = 1.0f;
    self.tokenName = self.cData.tokenName;
    self.customNavBar.title = TPString(@"%@%@",self.transType == TPTransactionTypeTransfer ? @"购买":@"出售",self.tokenName);
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"list_icon_1"]];
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^
    {
        TPBuyRecordViewController *VC = [TPBuyRecordViewController new];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/info" parameters:@{@"pairId":self.pairId,@"transactionType":_transType == TPTransactionTypeTransferOut ? @"1":@"2"} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
//            NSLog(@"挂单信息：%@",responseObject[@"data"]);
            self.transInfo = [TPTransInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            CGFloat tkBalance = [QuickMaker makeFloatNumber:[self.transInfo.tokenBalance floatValue] tailNum:4];
            CGFloat blance = [QuickMaker makeFloatNumber:[self.transInfo.balance floatValue] tailNum:4];
            
            self.sellLabs[0].text = TPString(@"%.4f",tkBalance);
            self.sellLabs[1].text = TPString(@"%.4f",blance);
            if (self.isPublish)
            {
                self.publishView.transModel = self.transInfo;
            }
            self.publishView.comSlider.slider.maxValue = 100 + [self.transInfo.max floatValue];
            self.publishView.comSlider.slider.minValue = 100 + [self.transInfo.min floatValue];
            self.publishView.comSlider.slider.value = 100;
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"挂单信息获取失败 error = %@", error);
    }];
    
    [self setUpheaderView];
    [self setUpContentView];
    [self setUpbBottomBtn];
}

-(void)setUpheaderView
{
    _headerView = [[UIView alloc] init];
    [_headerView setLayer:5 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:_headerView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.top.equalTo(@(StatusBarAndNavigationBarHeight + 12));
         make.height.equalTo(@102);
         make.width.equalTo(@355);
     }];
    NSArray *titArr = @[TPString(@"可用%@",self.tokenName),TPString(@"可用%@",@"BZTB")];
    NSMutableArray *balanceArr = [NSMutableArray array];
    for (int i = 0; i <titArr.count ; i++)
    {
        BalanceHeaderView *balaceLView = [[BalanceHeaderView alloc] initWithTitle:titArr[i] WithAmount:@"123456.123"];
        [_headerView addSubview:balaceLView];
        [balanceArr addObject:balaceLView];
        [self.sellLabs addObject:balaceLView.amountLab];
    }
    
    [balanceArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [balanceArr mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.headerView.mas_top);
        make.width.equalTo(self.headerView.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.headerView.mas_height);
    }];
    
    UIView *sepView = [[UIView alloc] init];
    sepView.backgroundColor = [UIColor colorWithHex:@"#E1E1E1"];
    [_headerView addSubview:sepView];
    
    [sepView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.center.equalTo(self.headerView);
        make.height.equalTo(@32);
        make.width.equalTo(@1);
    }];
}



-(void)setUpContentView
{
    _bottomView = [[UIView alloc] init];
    [_bottomView setLayer:5 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.headerView.mas_bottom).with.offset(12);
         make.height.equalTo(self.isPublish ? @303:@262);
         make.width.equalTo(@355);
     }];
    
    TPNonPublish * nonPublish;
    TPPublish * publishView;

    if (!self.isPublish)
    {
        nonPublish = [[TPNonPublish alloc] initWithTransType:self.transType tokenName:self.cData.tokenName currName:self.currName];
        nonPublish.transModel = self.transModel;
        [_bottomView addSubview:nonPublish];
        self.nonPublish = nonPublish;
        [nonPublish mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.left.equalTo(@0);
            make.width.equalTo(self.bottomView.mas_width);
            make.height.equalTo(@100);
        }];
    }
        else
    {
        publishView = [[TPPublish alloc]initWithTransType:self.transType tokenName:self.cData.tokenName currName:self.currName];

        [_bottomView addSubview:publishView];
        self.publishView = publishView;
        [publishView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.equalTo(@0);
            make.width.equalTo(self.bottomView.mas_width);
            make.height.equalTo(@153);
        }];
        publishView.sliderBlock = ^(SJSlider * _Nonnull slider)
        {
            self.currentPrice = slider.value / 100;
        
            if (self.comText.comTextField.text.length > 0)
            {
                CGFloat com = [QuickMaker makeFloatNumber:[self.comText.comTextField.text floatValue] tailNum:4] ;
                CGFloat price = [QuickMaker makeFloatNumber:[self.transInfo.price floatValue] tailNum:4] ;
                CGFloat conLab_v = com * price * slider.value / 100;
                conLab_v = [QuickMaker makeFloatNumber:conLab_v tailNum:4];
                self.conLab.text = TPString(@"%.4f %@",conLab_v ,@"BZTB");
                NSLog(@"dsjdkjsldjlsjdklsjdkjslkdjlsd");
                
            }
        };
    }
    NSArray *titleArr;
    NSArray *placeArr;
    if (self.transType == TPTransactionTypeTransferOut)
    {
        titleArr = @[@"出售数量"];
        placeArr = @[@"输入出售数量"];
    }
        else
    {
        titleArr = @[@"购买数量"];
        placeArr = @[@"输入购买数量"];
    }
    
    TPComTextView *takeText;
    for (int i = 0 ; i < titleArr.count ; i++)
    {
        takeText = [[TPComTextView alloc] initWithTitle:titleArr[i] WithDesc:placeArr[i]];
        takeText.comTextField.keyboardType = UIKeyboardTypeDecimalPad;
        takeText.comTextField.secureTextEntry = NO;
        
        [takeText.comTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
        [_bottomView addSubview:takeText];
        self.comText = takeText;
        
        [takeText mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@0);
             make.top.equalTo(self.isPublish ? publishView.mas_bottom:nonPublish.mas_bottom).with.offset(self.isPublish?0:12);
             make.width.equalTo(self.bottomView.mas_width);
             make.height.equalTo(@71);
         }];
    }
    
    self.tsLab = [YFactoryUI YLableWithText:@"" color:[UIColor colorWithHex:@"#F33636"] font:FONT(13)];
    [_bottomView addSubview:self.tsLab];
    
    [self.tsLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(takeText.comTitleLabel.mas_left);
         make.top.equalTo(takeText.mas_bottom).with.offset(4);
         make.height.equalTo(@17);
     }];
    UILabel *proLab = [YFactoryUI YLableWithText:@"总价格：" color:TP8EColor font:FONT(13)];
    [_bottomView addSubview:proLab];
    [proLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(takeText.comTitleLabel.mas_left);
        make.height.equalTo(@17);
        make.top.equalTo(takeText.mas_bottom).with.offset(24);
    }];

    UILabel *conLab = [YFactoryUI YLableWithText:TPString(@"0 %@",@"BZTB") color:TPC1Color font:FONT(17)];
    [_bottomView addSubview:conLab];
    self.conLab = conLab;
    [conLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(takeText.comTitleLabel.mas_left);
         make.height.equalTo(@17);
         make.top.equalTo(proLab.mas_bottom).with.offset(6);
     }];
}

-(void)setUpbBottomBtn
{
    NSString *title = @"立即发布";
    if( self.isFromTableView ) {
        title = @"立即购买";
    }
    UIButton *reservationBtn = [YFactoryUI YButtonWithTitle:title Titcolor:[UIColor colorWithHex:@"#D5D7D6"] font:FONT(15) Image:nil target:self action:@selector(reservationClick)];
    [reservationBtn setLayer:22 WithBackColor:TPMainColor];
    self.reservationBtn = reservationBtn;
    [self.view addSubview:reservationBtn];
    [reservationBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(-(56 + HOME_INDICATOR_HEIGHT));
         make.width.equalTo(@343);
         make.height.equalTo(@44);
     }];
    [self reservationBtnUerEnabled:NO];
}

-(void)reservationBtnUerEnabled:(BOOL)enabled
{
    self.reservationBtn.userInteractionEnabled = enabled ? YES:NO;
    self.reservationBtn.backgroundColor = enabled ? TPMainColor:[UIColor colorWithHex:@"#EBF1FB"];
    [self.reservationBtn setTitleColor:enabled ? [UIColor whiteColor]:TPD5Color  forState:UIControlStateNormal];
}


-(void)changeText:(UITextField *)comText
{
    if (comText.text.length > 0)
    {
        [self reservationBtnUerEnabled:YES];
    }
        else
    {
        [self reservationBtnUerEnabled:NO];
    }
    
    if (!self.isPublish)
    {
        if ([comText.text floatValue]  > [self.transModel.limitValue floatValue])
        {
            self.tsLab.text = @"不能超出剩余数量";
            self.tsLab.hidden = NO;
            [self reservationBtnUerEnabled:NO];
        }
        else
        {
            self.tsLab.hidden = YES;
            [self reservationBtnUerEnabled:YES];
        }
    }

    if (self.isPublish)
    {
        CGFloat com = [QuickMaker makeFloatNumber: [comText.text floatValue] tailNum:4];
        CGFloat price = [QuickMaker makeFloatNumber:[self.transInfo.price floatValue] tailNum:4] ;
        CGFloat currentPrice = [QuickMaker makeFloatNumber:self.currentPrice tailNum:4];
//        CGFloat conLab_v = [comText.text floatValue] * [self.transInfo.price floatValue] * self.currentPrice;
        CGFloat conLab_v = com * price * currentPrice;
        conLab_v = [QuickMaker makeFloatNumber:conLab_v tailNum:4];
        self.conLab.text = TPString(@"%.4f %@",conLab_v,@"BZTB");
    }
        else
    {
        
        CGFloat com = [QuickMaker makeFloatNumber: [comText.text floatValue] tailNum:4];
        CGFloat price = [QuickMaker makeFloatNumber:[self.transInfo.price floatValue] tailNum:4] ;
        CGFloat conLab_v_2 = com * price;
        conLab_v_2 = [QuickMaker makeFloatNumber:conLab_v_2 tailNum:4];
        self.conLab.text = TPString(@"%.4f %@",conLab_v_2,@"BZTB");
    }
}


-(void)reservationClick
{
    NSLog(@"发布");
    TPTransView *transView = [TPTransView createTransferViewStyle:self.transType == TPTransactionTypeTransferOut ? TPTransStyleReleaseSell : TPTransStyleReleaseBuy];
    
    transView.title = @"确认发布";
    transView.desc = @"总计需支付";
    
    if (self.isPublish)
    transView.Total = TPString(@"%.4f %@",[self.comText.comTextField.text floatValue],self.tokenName);
    else
    transView.Total = self.conLab.text;
    
    
    /*
     * 数量
     */
    if (self.isPublish)
    transView.con1 = TPString(@"%.4f %@",[self.comText.comTextField.text floatValue] * [self.transInfo.price floatValue] * self.currentPrice,self.currName);
    else
    transView.con1 = TPString(@"%.2f %@",[self.comText.comTextField.text floatValue],self.tokenName);
    
    
    /*
     * 单价
     */
    if (self.isPublish)
    transView.con2 =  TPString(@"%.4f %@",[self.transInfo.price floatValue] *self.currentPrice,self.currName);
    else
    transView.con2 = TPString(@"%.4f %@",[self.transModel.price floatValue],self.currName);
    
    [transView showMenuWithAlpha:YES];

    __block TPTransView *TPTransV = transView;
    [transView.pasView setEndEditBlock:^(NSString *text)
    {
        if (text.length == 6)
        {
            CGFloat price = 0.0;
            if (self.isPublish)
            price = [self.transInfo.price floatValue] * self.currentPrice;
            [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"transaction" parameters:@{ @"id":self.transModel ? self.transModel.id:@"0",
                              @"pairId":self.pairId,
                              @"password":[QuickGet encryptPwd:text email:nil],
                              @"price":self.isPublish ? @(price):self.transModel.price,
                              @"transactionType":self.transType == TPTransactionTypeTransfer ? @"1":@"2",
                              @"value":self.comText.comTextField.text} success:^(id responseObject, BOOL isCacheObject)
            {
                if ([responseObject[@"code"] isEqual:@200])
                {
                    if (self.isPublish)
                        [self showSuccessText:@"挂单成功"];
                    else {
                        if (self.transType == TPTransactionTypeTransferOut)
                        {
                            [self showSuccessText:@"出售成功"];
                        }else {
                            [self showSuccessText:@"购买成功"];
                        }
                    }
                    [TPTransV showMenuWithAlpha:NO];
                    [TPNotificationCenter postNotificationName:TPTakeOutSuccessNotification object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                    else
                {
                    [self showErrorText:responseObject[@"message"]];
                    [TPTransV showMenuWithAlpha:NO];
                }
            }
                failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
            {
                NSLog(@"发起挂单失败 %@",error.userInfo);
                [self showErrorText:@"挂单失败"];
                [TPTransV showMenuWithAlpha:NO];
            }];
            
        }
    }];
    
}



@end

@implementation BalanceHeaderView

- (instancetype)initWithTitle:(NSString *)title WithAmount:(NSString *)amount
{
    self = [super init];
    if (self)
    {
        self.titLab = [YFactoryUI YLableWithText:title color:TPC1Color font:FONT(12)];
        [self addSubview:self.titLab];
        [self.titLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self);
            make.height.equalTo(@16);
            make.top.equalTo(@27);
        }];
        
        
        self.amountLab = [YFactoryUI YLableWithText:amount color:TP59Color font:FONT(14)];
        [self addSubview:self.amountLab];
        
        [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.equalTo(self);
             make.height.equalTo(@16);
             make.top.equalTo(self.titLab.mas_bottom).with.offset(12);
         }];
    }
    return self;
}



@end
