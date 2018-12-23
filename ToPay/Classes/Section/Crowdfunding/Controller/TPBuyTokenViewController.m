//
//  TPBuyTokenViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBuyTokenViewController.h"
#import "TPComTextView.h"
#import "TPTransView.h"
@interface TPBuyTokenViewController ()

@property (nonatomic, copy) NSString * available;
@property (nonatomic, copy) NSString * mostlimit;
@property (nonatomic, copy) NSString * leastlimit;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *mostlimitLab;
@property (nonatomic, strong) UILabel *leastlimitLab;
@property (nonatomic, strong) UILabel *availableLab;
@property (nonatomic, strong) UILabel *proportionLab;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *VRTLab;
@property (nonatomic, strong) UILabel *promptLab;

@property (nonatomic, strong) TPComTextView *buyTextView;
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UIButton *reservationBtn;
@property (nonatomic, strong) TPCrowdfundingModel *croModel;
@end

@implementation TPBuyTokenViewController

- (instancetype)initWithCroModel:(TPCrowdfundingModel *)croModel;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.croModel = croModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self createheaderView];
    [self createBottomView];
    [self createBtn];
    
    
    [self setCroModel:self.croModel];
}

-(void)setCroModel:(TPCrowdfundingModel *)croModel
{
    _croModel = croModel;
    
    self.customNavBar.title = TPString(@"预约%@",self.croModel.projectName);
    self.nickLab.text = self.croModel.projectName;
    
    [self.iconV setIconHeader:self.croModel.projectImage placeholderImage:@"default_project"];
    
    self.proportionLab.text = TPString(@"兑换比例 1%@ = %@%@",croModel.tokenName,croModel.ratio,croModel.baseTokenName);
    

    [[WYNetworkManager sharedManager]sendGetRequest:WYJSONRequestSerializer url:TPString(@"project/%@/purchase",self.croModel.projectId) parameters:@{@"id":self.croModel.projectId} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             self.mostlimitLab.text = TPString(@"最多预约：%@",responseObject[@"data"][@"limitValue"]);
             self.leastlimitLab.text = TPString(@"最少预约：%@",responseObject[@"data"][@"projectMin"]);
             self.availableLab.text = TPString(@"可用VRT：%@",responseObject[@"data"][@"balance"]);
             self.mostlimit = responseObject[@"data"][@"limitValue"];
             self.leastlimit = responseObject[@"data"][@"projectMin"];
             self.available = TPString(@"%@",responseObject[@"data"][@"balance"]);
         }
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"获取项目购买信息失败 %@",error);
         [self showErrorText:@"网络错误，请稍后重新尝试"];
     }];
}

-(void)createheaderView
{
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    
    [headerView setLayer:5 WithBackColor:[UIColor whiteColor]];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@10);
        make.top.equalTo(@(StatusBarAndNavigationBarHeight + 10));
        make.right.equalTo(self.view).with.offset(-10);
        make.height.equalTo(@82);
    }];
    self.headerView = headerView;
    
    UIImageView *iconV = [YFactoryUI YImageViewWithimage:nil];
    [iconV setLayer:5 WithBackColor:YRandomColor];
    [headerView addSubview:iconV];
    self.iconV = iconV;
    [iconV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(headerView);
        make.left.equalTo(@16);
        make.size.equalTo(@48);
    }];
    
    UILabel *nickLab = [YFactoryUI YLableWithText:@"POT" color:TP59Color font:FONT(17)];
    [headerView addSubview:nickLab];
    self.nickLab = nickLab;
    [nickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(iconV.mas_right).with.offset(12);
         make.top.equalTo(@8);
         make.height.equalTo(@22);
     }];
    
    UILabel *mostlimitLab = [YFactoryUI YLableWithText:@"最多预约：15000" color:TP8EColor font:FONT(11)];
    [headerView addSubview:mostlimitLab];
    self.mostlimitLab = mostlimitLab;
    [mostlimitLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(iconV.mas_right).with.offset(12);
         make.top.equalTo(nickLab.mas_bottom).with.offset(6);
         make.height.equalTo(@15);
     }];
    
    UILabel *leastlimitLab = [YFactoryUI YLableWithText:@"最少预约：100" color:TP8EColor font:FONT(11)];
    self.leastlimitLab = leastlimitLab;
    [headerView addSubview:leastlimitLab];
    [leastlimitLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(iconV.mas_right).with.offset(12);
         make.top.equalTo(mostlimitLab.mas_bottom).with.offset(4);
         make.height.equalTo(@15);
     }];
    
    UILabel *proportionLab = [YFactoryUI YLableWithText:@"兑换比例 1PTO = 500 VRT" color:TP8EColor font:FONT(11)];
    [headerView addSubview:proportionLab];
    self.proportionLab = proportionLab;
    [proportionLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(headerView.mas_right).with.offset(-16);
         make.top.equalTo(mostlimitLab.mas_top);
         make.height.equalTo(@15);
     }];
    
    
}

-(void)createBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setLayer:5 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.headerView.mas_bottom).with.offset(12);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(@191);
    }];
    
    TPComTextView *buyTextView = [[TPComTextView alloc] initWithTitle:@"购买数量" WithDesc:@"输入预约数量"];
    [buyTextView.comTextField addTarget:self action:@selector(didChange:)
                       forControlEvents:UIControlEventEditingChanged];
    buyTextView.comTextField.keyboardType = UIKeyboardTypePhonePad;
    buyTextView.comTextField.secureTextEntry = NO;
    self.buyTextView = buyTextView;
    [bottomView addSubview:buyTextView];
    [buyTextView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@10);
        make.width.equalTo(bottomView.mas_width);
        make.height.equalTo(@71);
    }];

    //    default_coin
    
    self.promptLab = [YFactoryUI YLableWithText:@"" color:[UIColor colorWithHex:@"#F33636"] font:FONT(13)];
    [bottomView addSubview:self.promptLab];
//    self.promptLab.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
//    self.promptLab.hidden = YES;
    
    [self.promptLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@20);
        make.top.equalTo(buyTextView.mas_bottom).with.offset(4);
        make.height.equalTo(@17);
    }];
    
    
    UILabel *totalLab = [YFactoryUI YLableWithText:@"总计需支付:" color:TP8EColor font:FONT(13)];
    [bottomView addSubview:totalLab];
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(buyTextView.comTextField.mas_left);
        make.top.equalTo(self.promptLab.mas_bottom).with.offset(8);
        make.height.equalTo(@17);
    }];
    
    UILabel *VRTLab = [YFactoryUI YLableWithText:@"VRT 0.00" color:TP59Color font:FONT(17)];
    [bottomView addSubview:VRTLab];
    self.VRTLab = VRTLab;
    [VRTLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(buyTextView.comTextField.mas_left);
         make.top.equalTo(totalLab.mas_bottom).with.offset(10);
         make.height.equalTo(@22);
     }];
    
    
    UILabel *availableLab = [YFactoryUI YLableWithText:@"" color:TP8EColor font:FONT(13)];
    [bottomView addSubview:availableLab];
    self.availableLab = availableLab;
    [availableLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(buyTextView.comTextField.mas_left);
         make.top.equalTo(VRTLab.mas_bottom).with.offset(4);
         make.height.equalTo(@17);
     }];
}

-(void)createBtn
{
    
    UIButton *reservationBtn = [YFactoryUI YButtonWithTitle:@"立即预约" Titcolor:TPD5Color font:FONT(15) Image:nil target:self action:@selector(reservationClick)];
    reservationBtn.userInteractionEnabled = NO;
    [reservationBtn setLayer:22 WithBackColor:[UIColor colorWithHex:@"#EBF1FB"]];
    self.reservationBtn = reservationBtn;
    
    [self.view addSubview:reservationBtn];
    
    [reservationBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(-(56 + HOME_INDICATOR_HEIGHT));
         make.width.equalTo(@343);
         make.height.equalTo(@44);
     }];
}

-(void)didChange:(UITextField *)comText
{
    if (comText.text.length > 0)
    {
        self.VRTLab.text = TPString(@"%.2f VRT",[comText.text floatValue] * [_croModel.ratio floatValue]);
        
        if ([self.VRTLab.text floatValue] > [self.available floatValue])
        {
            self.availableLab.text = @"可用金额不足!";
            self.availableLab.textColor = [UIColor colorWithHex:@"#F33636"];
            [self reservationBtnUerEnabled:NO];
        }
            else
        {
            self.promptLab.hidden = YES;
            self.availableLab.text = TPString(@"可用VRT %@",self.available);
            self.availableLab.textColor = TP8EColor;
            [self reservationBtnUerEnabled:YES];
        }
        
        
        if ([comText.text floatValue] < [self.leastlimit floatValue])
        {
            self.promptLab.text = @"低于最小的预约数量!";
            self.promptLab.hidden = NO;
            [self reservationBtnUerEnabled:NO];
        }
            else if ([comText.text floatValue] > [self.mostlimit floatValue])
        {
            self.promptLab.text = @"超出最大的预约数量！";
            self.promptLab.hidden = NO;
            [self reservationBtnUerEnabled:NO];
        }
            else
        {
            self.promptLab.hidden = YES;
            [self reservationBtnUerEnabled:YES];
        }
    }
        else
    {
        self.promptLab.hidden = YES;
        self.VRTLab.text = @"0.00 VRT";
    }
}

-(void)reservationBtnUerEnabled:(BOOL)enabled
{
    self.reservationBtn.userInteractionEnabled = enabled ? YES:NO;
    self.reservationBtn.backgroundColor = enabled ? TPMainColor:[UIColor colorWithHex:@"#EBF1FB"];
    [self.reservationBtn setTitleColor:enabled ? [UIColor whiteColor]:TPD5Color  forState:UIControlStateNormal];
}

-(void)reservationClick
{
    TPTransView *transView = [TPTransView createTransferViewStyle:TPTransStyleReservation];
    transView.title = @"确认预约";
    transView.desc = @"总计需支付";
    transView.Total = self.VRTLab.text;
    transView.con1 = TPString(@"%@%@",self.buyTextView.comTextField.text,self.croModel.projectName);
    [transView showMenuWithAlpha:YES];
    
    __block TPTransView *TPTransV = transView;
    
    [transView.pasView setEndEditBlock:^(NSString *text)
     {
         if (text.length == 6)
         {
             [SVProgressHUD show];
             
             NSLog(@"<<<<<<<%@ %@>>>>>>",text,self.buyTextView.comTextField.text);
             WYNetworkManager *manage = [WYNetworkManager sharedManager];
             NSLog(@"%@",manage.customHeaders);
             
             [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:TPString(@"project/%@/purchase",self.croModel.projectId) parameters:@{@"password":text,@"value":self.buyTextView.comTextField.text} success:^(id responseObject, BOOL isCacheObject)
             {
                 if ([responseObject[@"code"] isEqual:@200])
                 {
                     [self showSuccessText:@"购买成功"];
                     
                     [TPTransV showMenuWithAlpha:NO];
                     [TPNotificationCenter postNotificationName:TPAssetRedNotification object:nil];
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                    else
                 {
                     [TPTransV showMenuWithAlpha:NO];
                     [self showInfoText:responseObject[@"message"]];
                 }
             }
                failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
             {
                 [self showErrorText:@"购买失败"];
                 [TPTransV showMenuWithAlpha:NO];
             }];
         }
     }];
}

-(void)dealloc
{
    [TPNotificationCenter removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
