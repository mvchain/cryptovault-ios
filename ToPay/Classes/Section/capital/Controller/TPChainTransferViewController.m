//
//  TPChainTransferViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPChainTransferViewController.h"
#import "TPComTextView.h"
#import "TPTransView.h"
@interface TPChainTransferViewController ()

@end

@implementation TPChainTransferViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.title = @"BTC转账";
    self.customNavBar.title = @"BTC转账";
    
    
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
        make.height.equalTo(@267);
    }];
    
    NSArray *titArray = @[@"收款地址",@"转账金额"];
    NSArray *descArray = @[@"输入地址",@"输入转账金额"];
    
    TPComTextView *textView;
    for (int i = 0; i <titArray.count ; i++)
    {
        textView = [[TPComTextView alloc] initWithTitle:titArray[i] WithDesc:descArray[i]];
        [backView addSubview:textView];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@0);
            make.top.equalTo(@19).with.offset(19 + i * 94);
            make.width.equalTo(backView.mas_width);
            make.height.equalTo(@71);
        }];
    }
    
    UILabel *descLab = [YFactoryUI YLableWithText:@"交易手续费" color:TPA7Color font:FONT(13)];
    [backView addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@20);
        make.top.equalTo(textView.mas_bottom).with.offset(23);
    }];
    
    UILabel *numLab = [YFactoryUI YLableWithText:@"0.001BTC" color:TP59Color font:FONT(15)];
    [backView addSubview:numLab];
    
    [numLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(descLab);
        make.top.equalTo(descLab.mas_bottom).with.offset(10);
        make.height.equalTo(@20);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)confirClcik
{
//    NSLog(@"确认");
    TPTransView *transView = [TPTransView createTransferView];
    [transView showMenuWithAlpha:YES];
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
