//
//  TPChainReceiptViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPChainReceiptViewController.h"

@interface TPChainReceiptViewController ()

@end

@implementation TPChainReceiptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.customNavBar.title = @"BTC收款";
    [self createUI];
}

-(void)createUI
{
    UIView *backView = [[UIView alloc] init];
    [backView setLayer:16 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(119 + STATUS_BAR_HEIGHT));
        make.width.equalTo(@335);
        make.height.equalTo(@392);
    }];
    
    UIImageView *iconImgV = [YFactoryUI YImageViewWithimage:nil];
    iconImgV.backgroundColor = YRandomColor;
    [self.view addSubview:iconImgV];
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(backView);
        make.centerY.equalTo(backView.mas_top);
        make.size.equalTo(@56);
    }];
    
    
    UILabel *descLab = [YFactoryUI YLableWithText:@"BTC收款地址" color:TP59Color font:FONT(14)];
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(backView);
        make.top.equalTo(iconImgV.mas_bottom).with.offset(13);
        make.height.equalTo(@19);
    }];
    
    UILabel *addressLab = [YFactoryUI YLableWithText:@"0x2051dd2b...a196ccc2448" color:TP8EColor font:FONT(13)];
    [self.view addSubview:addressLab];
    
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(backView);
         make.top.equalTo(descLab.mas_bottom).with.offset(6);
         make.height.equalTo(@19);
     }];
    
    UIImageView *QRView = [YFactoryUI YImageViewWithimage:nil];
    QRView.backgroundColor = YRandomColor;
    [self.view addSubview:QRView];
   
    [QRView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(backView);
         make.top.equalTo(addressLab.mas_bottom).with.offset(19);
         make.size.equalTo(@245);
     }];
    
    UIImageView *logoImgV = [YFactoryUI YImageViewWithimage:nil];
    logoImgV.backgroundColor = YRandomColor;
    [self.view addSubview:logoImgV];
    
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(backView.mas_bottom).with.offset(45);
        make.size.equalTo(@56);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
