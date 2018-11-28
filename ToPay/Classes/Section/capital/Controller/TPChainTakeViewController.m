//
//  TPChainTakeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPChainTakeViewController.h"
#import "TPComTextView.h"
@interface TPChainTakeViewController ()

@end

@implementation TPChainTakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.customNavBar.title = @"余额取出";
    [self createUI];
}

-(void)createUI
{
    UIView *backView = [[UIView alloc] init];
    [backView setLayer:5 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@10);
         make.top.equalTo(@(StatusBarAndNavigationBarHeight + 10));
         make.right.equalTo(self.view).with.offset(-10);
         make.height.equalTo(@173);
     }];
    
    TPComTextView *takeText = [[TPComTextView alloc] initWithTitle:@"取出余额" WithDesc:@"输入取出余额"];
    [backView addSubview:takeText];
    
    [takeText mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.top.equalTo(@19);
         make.width.equalTo(backView.mas_width);
         make.height.equalTo(@71);
     }];
    
    UILabel *balanceLab = [YFactoryUI YLableWithText:@"余额：1235.1234" color:TP8EColor font:FONT(12)];
    [takeText addSubview:balanceLab];
    
    [balanceLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(takeText.comTextField);
        make.height.equalTo(@16);
        make.top.equalTo(takeText.comTitleLabel);
    }];
    
    UILabel *promptLab = [YFactoryUI YLableWithText:@"取出后，余额会转入vpay应用内使用" color:[UIColor colorWithHex:@"#E86636"] font:FONT(12)];
    [backView addSubview:promptLab];
    
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(takeText.comTextField).with.offset(4);
         make.height.equalTo(@16);
         make.top.equalTo(takeText.mas_bottom).with.offset(2);
     }];
    
    UIButton *confirmBtn = [YFactoryUI YButtonWithTitle:@"确认" Titcolor:[UIColor whiteColor] font:FONT(15) Image:nil target:self action:@selector(confirClcik)];
    [confirmBtn setLayer:22 WithBackColor:TPMainColor];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(self.view).with.offset(-(HOME_INDICATOR_HEIGHT + 54));
         make.height.equalTo(@44);
         make.width.equalTo(@343);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)confirClcik
{
    NSLog(@"确认");
}

@end
