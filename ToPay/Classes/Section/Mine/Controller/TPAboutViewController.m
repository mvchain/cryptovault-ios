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
    
  
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
