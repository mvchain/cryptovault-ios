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

@property (nonatomic, strong) UILabel *formalitiesLab;
@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, strong) NSDictionary *DataSources;
@property (nonatomic, strong) NSMutableArray <TPComTextView *> *textArray;
@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation TPChainTransferViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //       [TPTransV showMenuWithAlpha:NO];
    //       [TPNotificationCenter postNotificationName:TPTakeOutSuccessNotification object:nil];
    //       [self.navigationController popViewControllerAnimated:YES];
    self.textArray = [NSMutableArray<TPComTextView *> array];
    
    self.customNavBar.title = TPString(@"%@转账",self.assetModel.tokenName);
    
    [self createUI];
    
    
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/transaction" parameters:@{@"tokenId":self.assetModel.tokenId} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            self.DataSources = responseObject[@"data"];
            self.balanceLab.text = TPString(@"余额：%@",self.DataSources[@"balance"]);
            self.formalitiesLab.text = TPString(@"%@ %@",self.DataSources[@"fee"],self.DataSources[@"feeTokenName"]);
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"划账失败 %@",error);
    }];
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
        make.height.equalTo(@280);
    }];
    
    NSArray *titArray = @[@"收款地址",@"转账金额"];
    NSArray *descArray = @[@"输入地址",@"输入转账金额"];
    
    TPComTextView *textView;
    for (int i = 0; i <titArray.count ; i++)
    {
        textView = [[TPComTextView alloc] initWithTitle:titArray[i] WithDesc:descArray[i]];
        [backView addSubview:textView];
        [textView.comTextField addTarget:self action:@selector(didChangeText:) forControlEvents:UIControlEventEditingChanged];
        [self.textArray addObject:textView];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@0);
            make.top.equalTo(@19).with.offset(19 + i * 94);
            make.width.equalTo(backView.mas_width);
            make.height.equalTo(@71);
        }];
        
        if (i == 1) {
            textView.comTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
    UILabel *balanceLab = [YFactoryUI YLableWithText:@"余额：1236.1234" color:TP8EColor font:FONT(13)];
    [backView addSubview:balanceLab];
    self.balanceLab = balanceLab;
    [balanceLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@20);
        make.top.equalTo(textView.mas_bottom).with.offset(8);
        make.height.equalTo(@17);
    }];
    
    UILabel *descLab = [YFactoryUI YLableWithText:@"交易手续费" color:TPA7Color font:FONT(13)];
    [backView addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@20);
        make.top.equalTo(balanceLab.mas_bottom).with.offset(20);
    }];
    
    UILabel *formalitiesLab = [YFactoryUI YLableWithText:@"0.001BTC" color:TP59Color font:FONT(15)];
    [backView addSubview:formalitiesLab];
    self.formalitiesLab = formalitiesLab;
    [formalitiesLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(descLab);
        make.top.equalTo(descLab.mas_bottom).with.offset(8);
        make.height.equalTo(@19);
    }];
    
    
    UIButton *confirmBtn = [YFactoryUI YButtonWithTitle:@"确认" Titcolor:TPD5Color font:FONT(15) Image:nil target:self action:@selector(confirClcik)];
    confirmBtn.userInteractionEnabled = NO;
    [confirmBtn setLayer:22 WithBackColor:TPEBColor];
    [self.view addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    
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

-(void)didChangeText:(UITextField *)textF
{
    if (self.textArray[0].comTextField.text.length > 0 && self.textArray[1].comTextField.text.length > 0)
    {
        self.confirmBtn.userInteractionEnabled = YES;
        [self.confirmBtn setLayer:22 WithBackColor:TPMainColor];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}



-(void)confirClcik
{
//    NSLog(@"确认");
    TPTransView *transView = [TPTransView createTransferView];
    [transView showMenuWithAlpha:YES];
    
    __block TPTransView *TPTransV = transView;
    [transView.pasView setEndEditBlock:^(NSString *text)
    {
        if (text.length == 6)
        {
            [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"asset/transaction" parameters:@{@"address":self.textArray[0].comTextField.text,
                            @"password":text,
                            @"tokenId":self.assetModel.tokenId,
                            @"value":self.textArray[1].comTextField.text} success:^(id responseObject, BOOL isCacheObject)
            {
                if ([responseObject[@"code"] isEqual:@200])
                {
                    NSLog(@"转账成功");
                    [TPTransV showMenuWithAlpha:NO];
                    
                    [TPNotificationCenter postNotificationName:TPTakeOutSuccessNotification object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
                failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
            {
                NSLog(@"转账失败");
            }];
        }
    }];
}

@end
