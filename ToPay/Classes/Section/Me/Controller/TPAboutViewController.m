//
//  TPAboutViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPAboutViewController.h"

@interface TPAboutViewController ()

@end

@implementation TPAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = TPF6Color;
    [self showSystemNavgation:NO];
    [self setUpViews];
}

-(void)setUpViews
{
    UIImageView *iconImgV = [YFactoryUI YImageViewWithimage:nil];
    iconImgV.backgroundColor = YRandomColor;
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
    
    UIButton *quitBtn = [YFactoryUI YButtonWithTitle:@"退出登录" Titcolor:[UIColor whiteColor] font:FONT(15) Image:nil target:self action:@selector(quitClcik)];
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


-(void)quitClcik
{
    NSLog(@"退出登录");
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
