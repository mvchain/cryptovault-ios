//
//  TPAboutViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPAboutViewController.h"
#import "TPLoginViewController.h"
#import "TPGuiderViewController.h"
#import "YUAlertViewController.h"
@interface TPAboutViewController ()

@end

@implementation TPAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = TPF6Color;
    self.customNavBar.title  = @"关于";
    
    [self showSystemNavgation:NO];
    [self setUpViews];
}

-(void)setUpViews
{
    UIImageView *iconImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"vp_Start icon"]];
    [self.view addSubview:iconImgV];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@144);
        make.size.equalTo(@60);
    }];
    
    UILabel *descLab = [YFactoryUI YLableWithText:@"当前版本1.0" color:TP59Color font:FONT(12)];
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.top.equalTo(iconImgV.mas_bottom).with.offset(20);
         make.height.equalTo(@16);
    }];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"检查更新" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@60);
        make.height.equalTo(@44);
    }];
    [btn addTarget:self action:@selector(updateNew:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)updateNew:(id)sender {
    [QuickDo checkShouldUpdateWithParentVC:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
