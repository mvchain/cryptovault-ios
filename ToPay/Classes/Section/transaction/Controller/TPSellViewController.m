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
@property (nonatomic, strong) TPComTextView *comText;

@property (nonatomic, strong) TPTransInfoModel *transInfo;

@property (nonatomic) TPTransactionType transType;
@property (nonatomic, copy)   NSString *pairId;
@property (nonatomic, copy)  NSString   * tokenName;
@property (nonatomic) BOOL isPublish;
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
    
    self.tokenName = self.cData.tokenName;
    self.customNavBar.title = TPString(@"%@%@",self.transType == TPTransactionTypeTransferOut? @"出售":@"购买",self.tokenName);
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"list_icon_1"]];
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^
    {
        TPBuyRecordViewController *VC = [TPBuyRecordViewController new];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/info" parameters:@{@"pairId":self.pairId,@"transactionType":_transType == TPTransactionTypeTransferOut ? @"2":@"1"} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
//            NSLog(@"挂单信息：%@",responseObject[@"data"]);
            self.transInfo = [TPTransInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.sellLabs[0].text = TPString(@"%.4f",[self.transInfo.tokenBalance floatValue]);
            self.sellLabs[1].text = TPString(@"%.4f",[self.transInfo.balance floatValue]);;
            
//            self.currentLab.text = TPString(@"%@:%@%@",self.transType == TPTransactionTypeTransferOut ? @"出售单价":@"购买单价",self.transInfo.price,self.currName);
//            self.isPublish ?  TPString(@"当前价格：%@ VRT",self.transInfo.price):TPString(@"%@ %@",self.transInfo.price,self.currName);
//            self.numLab.text = TPString(@"%@ %@",self.transInfo.price,self.currName);
//
//            self.comSlider.slider.maxValue = 100 + [self.transInfo.max floatValue];
//            self.comSlider.slider.minValue = 100 + [self.transInfo.min floatValue];
//            self.comSlider.slider.value = 100;
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
    
    NSArray *titArr = @[TPString(@"%@余额",self.tokenName),@"可用VRT"];
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
        nonPublish = [[TPNonPublish alloc] initWithTransType:self.transType];
        [_bottomView addSubview:nonPublish];
        
        [nonPublish mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.left.equalTo(@0);
            make.width.equalTo(self.bottomView.mas_width);
            make.height.equalTo(@100);
        }];
    }
        else
    {
        publishView = [[TPPublish alloc]initWithTransType:self.transType];
        [_bottomView addSubview:publishView];
        [publishView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.equalTo(@0);
            make.width.equalTo(self.bottomView.mas_width);
            make.height.equalTo(@153);
        }];
    }
    
    
    NSArray *titleArr; //= @[@"出售量"];
    NSArray *placeArr; //= @[@"输出卖出USDT数量"];
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
        takeText.comTextField.keyboardType = UIKeyboardTypeNumberPad;
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
    
    
//    if (!self.isPublish)
//    {
//        /** 剩余可 购买/出售 数量 */
////        @"剩余可xxx量"
//        UILabel *remainLab = [YFactoryUI YLableWithText:TPString(@"剩余可%@量:%@",self.transType == TPTransactionTypeTransferOut ? @"出售":@"购买",self.transModel.limitValue) color:TPA7Color font:FONT(12)];
//        [_bottomView addSubview:remainLab];
//
//        [remainLab  mas_makeConstraints:^(MASConstraintMaker *make)
//        {
//            make.left.equalTo(takeText.comTextField.mas_left);
//            make.top.equalTo(takeText.mas_bottom).with.offset(5);
//            make.height.equalTo(@16);
//        }];
//    }
    
    UILabel *proLab = [YFactoryUI YLableWithText:@"总价格：" color:TP8EColor font:FONT(13)];
    [_bottomView addSubview:proLab];
    [proLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(takeText.comTitleLabel.mas_left);
        make.height.equalTo(@17);
        make.top.equalTo(takeText.mas_bottom).with.offset(24);
    }];

    UILabel *conLab = [YFactoryUI YLableWithText:TPString(@"%@ 0.00",self.tokenName) color:TPC1Color font:FONT(17)];
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
    UIButton *reservationBtn = [YFactoryUI YButtonWithTitle:@"发布" Titcolor:[UIColor colorWithHex:@"#D5D7D6"] font:FONT(15) Image:nil target:self action:@selector(reservationClick)];
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


#pragma mark - SJSliderDelegate
-(void)sliderDidDrag:(SJSlider *)slider
{
//    self.percentageLab.text = TPString(@"%.2f%%",slider.value);
//    self.numLab.text = TPString(@"%.2f VRT",slider.value/100 * [self.transInfo.price floatValue]);
    
    if (self.comText.comTextField.text.length > 0)
    {
//        self.conLab.text = TPString(@"VRT %.2f",[self.comText.comTextField.text floatValue] * [self.numLab.text floatValue]);
        
    }
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
    
    if (self.isPublish)
    {
//        self.conLab.text = TPString(@"%@ %.2f",self.tokenName,[comText.text floatValue] * [self.numLab.text floatValue]);
    }
        else
    {
        self.conLab.text = TPString(@"%@ %.2f",self.tokenName,[comText.text floatValue] * [self.transInfo.price floatValue]);
    }
}


-(void)reservationClick
{
    NSLog(@"发布");
    TPTransView *transView = [TPTransView createTransferViewStyle:self.transType == TPTransactionTypeTransferOut ? TPTransStyleReleaseSell : TPTransStyleReleaseBuy];
    
    transView.title = @"确认发布";
    transView.desc = @"总计需支付";
    transView.Total = self.conLab.text;
    transView.con1 = TPString(@"%.2f %@",[self.comText.comTextField.text floatValue] * [self.transInfo.price floatValue],self.currName);
    transView.con2 = TPString(@"%@ %@",self.transInfo.price,self.currName);
    
    [transView showMenuWithAlpha:YES];
    
    __block TPTransView *TPTransV = transView;
    [transView.pasView setEndEditBlock:^(NSString *text)
    {
        if (text.length == 6)
        {

            [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"transaction" parameters:@{ @"id":self.transModel ? self.transModel.id:@"0",
                              @"pairId":self.pairId,
                              @"password":text,
                              @"price":self.transInfo.price,
                              @"transactionType":self.transType == TPTransactionTypeTransferOut ? @"2":@"1",
                              @"value":self.comText.comTextField.text} success:^(id responseObject, BOOL isCacheObject)
            {
                if ([responseObject[@"code"] isEqual:@200])
                {
                    [self showSuccessText:@"挂单成功"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
