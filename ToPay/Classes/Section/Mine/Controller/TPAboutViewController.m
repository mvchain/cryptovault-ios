//
//  TPAboutViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/16.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPAboutViewController.h"
#import "TPLoginViewController.h"
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
//    NSLog(@"退出登录");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"您确定要退出ToPay吗？"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
        if ([TPLoginUtil quitWithRemoveUserInfo])
        {
            [TPLoginUtil  quitWithRemoveUserInfo];
            
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *dele = (AppDelegate*)app.delegate;
            dele.window.rootViewController = [TPLoginViewController new];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //添加顺序和显示顺序相同
    [alertController addAction:cancelAction];
    [alertController addAction:resetAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
