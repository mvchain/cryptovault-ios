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
//#import "TPComTextView.h"

@interface TPSellViewController ()<SJSliderDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *currentLab;
@property (nonatomic, strong) UILabel *percentageLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) SJButtonSlider *comSlider;
@property (nonatomic, strong) NSMutableArray <UILabel *> *sellLabs;

@property (nonatomic, strong) TPTransInfoModel *transInfo;
@property (nonatomic, strong) UILabel *conLab;

@property (nonatomic, strong) TPComTextView *comText;
@property (nonatomic) TPTransactionType transType;
@property (nonatomic, copy)   NSString *pairId;
@end

@implementation TPSellViewController

- (instancetype)initWithPairId:(NSString *)pairId WithTransType:(TPTransactionType)transType
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _pairId = pairId;
        _transType = transType;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sellLabs = [NSMutableArray<UILabel *> array];
    
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
            self.sellLabs[0].text = self.transInfo.tokenBalance;
            self.sellLabs[1].text = self.transInfo.balance;
            self.currentLab.text = TPString(@"当前价格：%@",self.transInfo.price);
            self.numLab.text = TPString(@"%@ VRT",self.transInfo.price);

            self.comSlider.slider.maxValue = 100 + [self.transInfo.max floatValue];
            self.comSlider.slider.minValue = 100 + [self.transInfo.min floatValue];
            self.comSlider.slider.value = 100;
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
    
    NSArray *titArr = @[@"USDT余额",@"VRT余额"];
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
         make.height.equalTo(@317);
         make.width.equalTo(@355);
     }];
    
    UILabel *msLab = [YFactoryUI YLableWithText:@"出售价" color:TP8EColor font:FONT(13)];
    [_bottomView addSubview:msLab];
    
    [msLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@20);
        make.top.equalTo(@12);
        make.height.equalTo(@17);
    }];
    
    
    UILabel *currentLab = [YFactoryUI YLableWithText:@"当前价格 100 VRT" color:TPC1Color font:FONT(11)];
    [_bottomView addSubview:currentLab];
    self.currentLab = currentLab;
    [currentLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self.bottomView).with.offset(-20);
        make.top.equalTo(@14);
        make.height.equalTo(@15);
    }];
    
    UILabel *numLab = [YFactoryUI YLableWithText:@"123456.21 VRT" color:TP8EColor font:FONT(15)];
    [_bottomView addSubview:numLab];
    self.numLab = numLab;
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(msLab.mas_left);
        make.top.equalTo(msLab.mas_bottom).with.offset(8);
        make.height.equalTo(@20);
    }];
    
    UIView *sliderView = [[UIView alloc] init];
    [sliderView setLayer:5 WithBackColor:[UIColor colorWithHex:@"#ECEEF1"]];
    [_bottomView  addSubview:sliderView];
    
    [sliderView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@16);
        make.right.equalTo(@(-14));
        make.height.equalTo(@66);
        make.top.equalTo(numLab.mas_bottom).with.offset(12);
    }];
    
    
    SJButtonSlider *comSlider = [SJButtonSlider new];
    comSlider.rightText = @"＋";
    comSlider.leftText = @"－";
    
    [comSlider.slider setThumbCornerRadius:8 size:CGSizeMake(16, 16) thumbBackgroundColor:[UIColor whiteColor]];
    comSlider.slider.trackImageView.backgroundColor = TPC1Color;
    comSlider.slider.traceImageView.backgroundColor = TP59Color;
    comSlider.slider.delegate = self;
    self.comSlider = comSlider;
    [sliderView addSubview:comSlider];
    
    [comSlider mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(sliderView);
        make.width.equalTo(sliderView.mas_width).with.offset(-100);
    }];
    
    UILabel *percentageLab = [YFactoryUI YLableWithText:@"100%" color:TP59Color font:FONT(15)];
    [sliderView addSubview:percentageLab];
    self.percentageLab = percentageLab;
    [percentageLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(sliderView);
        make.right.equalTo(@(-19));
        make.height.equalTo(@20);
    }];
    
    NSArray *titleArr = @[@"出售量"];
    NSArray *placeArr = @[@"输出卖出USDT数量"];
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
             make.top.equalTo(sliderView.mas_bottom).with.offset( 19 + i * 85);
             make.width.equalTo(self.bottomView.mas_width);
             make.height.equalTo(@71);
         }];
    }
    
    UILabel *proLab = [YFactoryUI YLableWithText:@"总计需支付：" color:TP8EColor font:FONT(13)];
    [_bottomView addSubview:proLab];
    [proLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(takeText.comTitleLabel.mas_left);
        make.height.equalTo(@17);
        make.top.equalTo(takeText.mas_bottom).with.offset(23);
    }];
    
    UILabel *conLab = [YFactoryUI YLableWithText:@"VRT 0.00" color:TPC1Color font:FONT(17)];
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
    [self.view addSubview:reservationBtn];
    
    [reservationBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(-(56 + HOME_INDICATOR_HEIGHT));
         make.width.equalTo(@343);
         make.height.equalTo(@44);
     }];
}


#pragma mark - SJSliderDelegate
-(void)sliderDidDrag:(SJSlider *)slider
{
    self.percentageLab.text = TPString(@"%.2f",slider.value);
    self.numLab.text = TPString(@"%.2f VRT",slider.value/100 * [self.transInfo.price floatValue]);
    
    if (self.comText.comTextField.text.length > 0)
    {
        self.conLab.text = TPString(@"VRT %.2f",[self.comText.comTextField.text floatValue] * [self.numLab.text floatValue]);
    }
}


-(void)changeText:(UITextField *)comText
{
    self.conLab.text = TPString(@"VRT %.2f",[comText.text floatValue] * [self.numLab.text floatValue]);
}


-(void)reservationClick
{
    NSLog(@"发布");
    TPTransView *transView = [TPTransView createTransferView];
    [transView showMenuWithAlpha:YES];
    
    __block TPTransView *TPTransV = transView;
    [transView.pasView setEndEditBlock:^(NSString *text)
    {
        if (text.length == 6)
        {
            [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"transaction" parameters:@{ @"id":self.orderId ? self.orderId:@"0",
                              @"pairId":self.pairId,
                              @"password":text,
                              @"price":self.numLab.text,
                              @"transactionType":self.transType == TPTransactionTypeTransferOut ? @"2":@"1",
                              @"value":self.comText.comTextField.text} success:^(id responseObject, BOOL isCacheObject)
            {
                if ([responseObject[@"code"] isEqual:@200])
                {
//                    self.assetTopic = [TPAssetModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//                    [self.baseTableView reloadData];
                    
                    NSLog(@"发起挂单成功");
                    [TPTransV showMenuWithAlpha:NO];
                    
//                    [TPNotificationCenter postNotificationName:TPTakeOutSuccessNotification object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
                failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
            {
                NSLog(@"发起挂单失败");
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
