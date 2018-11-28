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
@interface TPSellViewController ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation TPSellViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.customNavBar.title = @"出售USDT";
    [self setUpheaderView];
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"list_icon_1"]];
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^
    {
        TPBuyRecordViewController *VC = [TPBuyRecordViewController new];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    [self setUpContentView];
    
    UIButton *reservationBtn = [YFactoryUI YButtonWithTitle:@"确认" Titcolor:[UIColor colorWithHex:@"#D5D7D6"] font:FONT(15) Image:nil target:self action:@selector(reservationClick)];
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
         make.height.equalTo(@253);
         make.width.equalTo(@355);
     }];
    
    NSArray *titleArr = @[@"出售价",@"出售量"];
    NSArray *placeArr = @[@"输入出售价格",@"输出卖出USDT数量"];
    TPComTextView *takeText;
    for (int i = 0 ; i < titleArr.count ; i++)
    {
        takeText = [[TPComTextView alloc] initWithTitle:titleArr[i] WithDesc:placeArr[i]];
        [_bottomView addSubview:takeText];
        
        [takeText mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@0);
             make.top.equalTo(@19).with.offset( 19 + i * 85);
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
    
    UILabel *conLab = [YFactoryUI YLableWithText:@"VRT 0.00" color:[UIColor colorWithHex:@"#ECECEC"] font:FONT(17)];
    [_bottomView addSubview:conLab];
    [conLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(takeText.comTitleLabel.mas_left);
         make.height.equalTo(@17);
         make.top.equalTo(proLab.mas_bottom).with.offset(6);
     }];
}

-(void)reservationClick
{
    NSLog(@"dasdas");
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
        UILabel *titLab = [YFactoryUI YLableWithText:title color:TPC1Color font:FONT(12)];
        [self addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self);
            make.height.equalTo(@16);
            make.top.equalTo(@27);
        }];
        
        
        UILabel *amountLab = [YFactoryUI YLableWithText:amount color:TP59Color font:FONT(14)];
        [self addSubview:amountLab];
        
        [amountLab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.equalTo(self);
             make.height.equalTo(@16);
             make.top.equalTo(titLab.mas_bottom).with.offset(12);
         }];
    }
    return self;
}



@end
