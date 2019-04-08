//
//  TPLoginViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/27.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPLoginViewController.h"
#import "TPLoginModel.h"
#import "AppDelegate.h"
#import "YUTabBarController.h"
#import "JKCountDownButton.h"
#import "TPRgeisterViewModel.h"
@interface TPLoginViewController ()

@property (nonatomic, strong) NSMutableArray<UITextField *> *textArr;

@end

@implementation TPLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textArr = [NSMutableArray<UITextField *> array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
    
    self.customNavBar.hidden = YES;
}

-(void)setUpUI
{
    UILabel *lab = [YFactoryUI YLableWithText:@"登录" color:TP59Color font:FONT(34)];
    [self.view addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.top.equalTo(@(StatusBarAndNavigationBarHeight + 12));
         make.height.equalTo(@46);
     }];
    
    NSArray *titleArr = @[@"邮箱",@"密码",@"验证码"];
    NSArray *descArr = @[@"请输入手机号",@"请输入密码",@"请输入验证码"];
    TPLoginTextView *loginTextView;
    for (int i = 0; i < titleArr.count ; i++ )
    {
        loginTextView = [[TPLoginTextView alloc] initWithTitle:titleArr[i] WithDesc:descArr[i]];
        
        if (i == 0 || i == 2)
        {
            loginTextView.comTextField.secureTextEntry = NO;
            if (i ==2)
                loginTextView.comTextField.keyboardType = UIKeyboardTypeNumberPad;
            if(i ==0)
                 loginTextView.comTextField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        
        if (i == 2)
        {
            
            JKCountDownButton *countDown = [[JKCountDownButton alloc] init];
            [countDown setTitle:@"获取验证码" forState:UIControlStateNormal];
            [countDown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            countDown.titleLabel.font = FONT(15);
            
            [countDown addTarget:self action:@selector(countDownClick:) forControlEvents:UIControlEventTouchUpInside];

            [countDown setLayer:22 WithBackColor:TP59Color];
            [loginTextView addSubview:countDown];
            
            [countDown mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.right.height.equalTo(loginTextView.comTextField);
                make.centerY.equalTo(loginTextView.comTextField);
                make.width.equalTo(@134);
            }];
        }
        
        [loginTextView.comTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:loginTextView];
        [self.textArr addObject:loginTextView.comTextField];
        [loginTextView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@0);
             make.top.equalTo(lab.mas_bottom).with.offset(32 + i * 87);
             make.width.equalTo(@(KWidth));
             make.height.equalTo(@71);
         }];
    }
    UIButton *quitBtn = [YFactoryUI YButtonWithTitle:@"登录" Titcolor:[UIColor whiteColor] font:FONT(15) Image:nil target:self action:@selector(loginClcik)];
    [quitBtn setLayer:23 WithBackColor:TPMainColor];
    [self.view addSubview:quitBtn];
    
    [quitBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(@(-54));
         make.height.equalTo(@44);
         make.width.equalTo(@343);
     }];
    
    
    UIButton *forgetBtn = [YFactoryUI YButtonWithTitle:@"忘记密码 ?" Titcolor:TP59Color font:FONT(12) Image:nil target:self action:@selector(forgetClick)];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.equalTo(quitBtn.mas_top).with.offset(-31);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@16);
    }];
}

-(void)forgetClick
{
    [SVProgressHUD showInfoWithStatus:@"请前往VP应用内修改账号密码"];
}

-(void)countDownClick:(JKCountDownButton *)btn
{
    
    if (![JudegeCenter isAvailableEmail:self.textArr[0].text] )
    {
        [self showInfoText:@"请输入正确的邮箱"];
    }
    [btn startCountDownWithSecond:60];
    
    
    TPRgeisterViewModel *reg = [[TPRgeisterViewModel alloc]init];
    [reg sendVaildCodeByEmail:self.textArr[0].text complete:^(BOOL isSucc) {
        if (isSucc) {
            [self showSuccessText:@"已发送"];
            [btn startCountDownWithSecond:60];
            btn.backgroundColor = TPA7Color;
        }else{
            [self showErrorText:@"发送失败"];
            
        }
    }];
    
   
}



-(void)changeTextField:(UITextField *)textField
{
    if (self.textArr[0] == textField) {
//        NSLog(@"账号：%@",textField.text);
    }
    
    if (self.textArr[1] == textField) {
//        NSLog(@"m密码：%@",textField.text);
    }
}

-(void)loginClcik
{
    //[SVProgressHUD show];
    [self showLoading];
    
    if (self.textArr[1].text.length == 0)
    {
        [self showInfoText:@"密码不能为空"];
        return ;
    }
    
    if (self.textArr[2].text.length <= 0)
    {
        [self showInfoText:@"请输入正确的验证码"];
        return ;
    }
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/login" parameters:@{@"username":self.textArr[0].text,
                     @"password":self.textArr[1].text,
                     @"validCode":self.textArr[2].text,
     } success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            NSLog(@"responseObject:%@",responseObject[@"data"]);
            TPLoginModel *loginM = [TPLoginModel mj_objectWithKeyValues:responseObject[@"data"]];
            // set Request token
            [QuickDo setJPushAlians:@(loginM.userId).stringValue];
            [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":loginM.token,@"Accept-Language":@"zh-cn"}];

            // Store user information
            [TPLoginUtil saveUserInfo:loginM];
            // Basic user information
            [TPLoginUtil setRequestInfo];
            // Get currency list
            [TPLoginUtil setRequestToken];
            [TPLoginUtil requestExchangeRate];
            [self showSuccessText:@"登录成功"];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *dele = (AppDelegate*)app.delegate;
            dele.window.rootViewController = [[YUTabBarController alloc] config];
        }
            else
        {
            [self showErrorText:responseObject[@"message"]];
            [self dismissLoading];
        }
        [self dismissLoading];
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"error = %@", error);
        [SVProgressHUD showSuccessWithStatus:@"登录失败"];
    }];
    
}

@end

@implementation TPLoginTextView

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc
{
    self = [super init];
    if (self)
    {
        [self setUpWithTitle:title desc:desc];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpWithTitle:@"" desc:@""];
        
    }
    return self;
}
- (void)noTitleLabel{
    [_comTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
         make.height.equalTo(@0);
    }];
    [_comTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.comTitleLabel.mas_bottom).with.offset(0);
    }];
}
- (void)setTitle:(NSString *)title desc:(NSString *)desc  {
    [_comTitleLabel setText:title];
    _comTextField.placeholder = desc;
}
- (void)setUpWithTitle:(NSString *)title desc:(NSString *)desc {
    _comTitleLabel = [YFactoryUI YLableWithText:title color:TP59Color font:FONT(13)];
    [self addSubview:_comTitleLabel];
    _comTextField = [YFactoryUI YTextFieldWithPlaceholder:[NSString stringWithFormat:@"%@",desc] color:TP8EColor font:FONT(15) secureTextEntry:YES delegate:nil];
    _comTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 0)];
    _comTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _comTextField.leftView.userInteractionEnabled = NO;
    _comTextField.leftViewMode = UITextFieldViewModeAlways;
    [_comTextField setLayerCornerRadius:22 WithColor:TP59Color WithBorderWidth:1];
    [self addSubview:_comTextField];
    [self.comTitleLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@0);
         make.left.equalTo(@32);
         make.height.equalTo(@17);
     }];
    [self.comTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@16);
         make.top.equalTo(self.comTitleLabel.mas_bottom).with.offset(10);
         make.width.equalTo(self).with.offset(-16*2);
         make.height.equalTo(@44);
     }];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end

