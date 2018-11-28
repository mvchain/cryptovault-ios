//
//  TPLoginViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/27.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPLoginViewController.h"

@interface TPLoginViewController ()

@end

@implementation TPLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
    
    
    
    
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
    
    NSArray *titleArr = @[@"手机号",@"密码"];
    NSArray *descArr = @[@"请输入手机号",@"请输入密码"];
    TPLoginTextView *loginTextView;
    for (int i = 0; i < titleArr.count ; i++ )
    {
        loginTextView = [[TPLoginTextView alloc] initWithTitle:titleArr[i] WithDesc:descArr[i]];
        [self.view addSubview:loginTextView];
        
        [loginTextView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(@0);
             make.top.equalTo(lab.mas_bottom).with.offset(32 + i * 87);
             make.width.equalTo(@(KWidth));
             make.height.equalTo(@71);
         }];
    }
    
    UILabel *forgetLab = [YFactoryUI YLableWithText:@"忘记密码 ?" color:TP59Color font:FONT(12)];
    [self.view addSubview:forgetLab];
    [forgetLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(loginTextView.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-32);
        make.height.equalTo(@16);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)loginClcik
{
    NSLog(@"登录事件");
}

@end

@implementation TPLoginTextView

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc
{
    self = [super init];
    if (self)
    {
        _comTitleLabel = [YFactoryUI YLableWithText:title color:TP59Color font:FONT(13)];
        [self addSubview:_comTitleLabel];
        
        
        _comTextField = [YFactoryUI YTextFieldWithPlaceholder:[NSString stringWithFormat:@"   %@",desc] color:TP8EColor font:FONT(15) secureTextEntry:YES delegate:nil];
        [_comTextField setLayerCornerRadius:22 WithColor:TP59Color WithBorderWidth:1];
        [self addSubview:_comTextField];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.comTitleLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@0);
         make.left.equalTo(@16);
         make.height.equalTo(@17);
     }];
    
    [self.comTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.comTitleLabel);
         make.top.equalTo(self.comTitleLabel.mas_bottom).with.offset(10);
         make.width.equalTo(@323);
         make.height.equalTo(@44);
     }];
}

@end

