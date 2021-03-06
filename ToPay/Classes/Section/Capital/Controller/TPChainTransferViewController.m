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
#import "TPTransferModel.h"
#import "TPTokenKindViewController.h"
#import "NIMScannerViewController.h"
@interface TPChainTransferViewController ()

@property (nonatomic, strong) UILabel *formalitiesLab;
@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, strong) NSDictionary *DataSources;
@property (nonatomic, strong) NSMutableArray <TPComTextView *> *textArray;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, copy) NSString *balance ;
@end
@implementation TPChainTransferViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textArray = [NSMutableArray<TPComTextView *> array];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    self.customNavBar.title = TPString(@"%@转账",self.assetModel.tokenName);
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"code_icon_black"]];
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^
    {
        NIMScannerViewController * scannerVC = [[NIMScannerViewController alloc] initWithCardName:@"hahaha" avatar:nil completion:^(NSString *stringValue)
        {
            weakSelf.textArray[0].comTextField.text = stringValue;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        scannerVC.tokenid = weakSelf.assetModel.tokenId;
        [weakSelf.navigationController pushViewController:scannerVC animated:YES];
    }];
    [self createUI];
    [self RequestTransaction];
}
- (void)RequestTransaction
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/transaction" parameters:@{@"tokenId":self.assetModel.tokenId} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"%@",responseObject[@"data"]);
             TPTransferModel *transfer = [TPTransferModel mj_objectWithKeyValues:responseObject[@"data"]];
             self.DataSources = responseObject[@"data"];
             float balance = [self.DataSources[@"balance"] floatValue];
             balance = [QuickMaker makeFloatNumber:balance tailNum:4];
             self.balanceLab.text = TPString(@"可用 %@：%.4f",self.assetModel.tokenName,balance);
             self.balance = self.DataSources[@"balance"];
             self.formalitiesLab.text = TPString(@"%.5f %@",transfer.fee,self.DataSources[@"feeTokenName"]);
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
        textView.comTextField.secureTextEntry = NO;
        [textView.comTextField addTarget:self action:@selector(didChangeText:) forControlEvents:UIControlEventEditingChanged];
        if (i == 0)
        {
             textView.comTextField.clearButtonMode = UITextFieldViewModeAlways;
            if (self.address) textView.comTextField.text = self.address;
        }
        [self.textArray addObject:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@0);
            make.top.equalTo(@19).with.offset(19 + i * 94);
            make.width.equalTo(backView.mas_width);
            make.height.equalTo(@71);
        }];
        if (i == 1) {
            textView.comTextField.keyboardType = UIKeyboardTypeDecimalPad;
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
    
    UILabel *formalitiesLab = [YFactoryUI YLableWithText:@"0.001BZTB" color:TP59Color font:FONT(15)];
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
    if (self.textArray[0].comTextField.text.length > 0 &&
        self.textArray[1].comTextField.text.length > 0 &&
        [self.textArray[1].comTextField.text floatValue] <= [self.balance floatValue] )
    {
        [self vaildButton];
        self.balanceLab.textColor = TP8EColor;
        float balance = [self.DataSources[@"balance"] floatValue];
        balance = [QuickMaker makeFloatNumber:balance tailNum:4];
        self.balanceLab.text = TPString(@"可用 %@：%.4f",self.assetModel.tokenName,balance);
    }else {
        [self invaildButton];
        
       
        
        if(  [self.textArray[1].comTextField.text floatValue] > [self.balance floatValue] ) {
            [self.balanceLab setText:TPString(@"可用 %@不足",self.assetModel.tokenName)];
            self.balanceLab.textColor = [UIColor colorWithHex:@"#F33636"];
        }else {
            self.balanceLab.textColor = TP8EColor;
            float balance = [self.DataSources[@"balance"] floatValue];
            balance = [QuickMaker makeFloatNumber:balance tailNum:4];
            self.balanceLab.text = TPString(@"可用 %@：%.4f",self.assetModel.tokenName,balance);
        }
    }
}
-(void)confirClcik
{
//    3 ETH
//    4 BTC
    if( ![JudegeCenter isVaildAddrWithTokenId:self.assetModel.tokenId addr:self.textArray[0].comTextField.text] ) {
         [self showInfoText:TPString(@"请输入正确的%@地址",self.assetModel.tokenName)];
        return;
    }
    TPTransView *transView = [TPTransView createTransferViewStyle:TPTransStyleTransfer];
    transView.title = @"确认转账";
    transView.desc = @"转账金额";
    transView.Total = TPString(@"%@ %@",self.textArray[1].comTextField.text,self.assetModel.tokenName);
    transView.con1 = self.textArray[0].comTextField.text;
    transView.con2 = self.formalitiesLab.text;
    [transView showMenuWithAlpha:YES];
     transView.pvc = self;
    __block TPTransView *TPTransV = transView;
    [transView.pasView setEndEditBlock:^(NSString *text)
    {
        if (text.length == 6)
        {
            [self showLoading];
            
            
            NSLog(@"%@",self.textArray[0].comTextField.text);
            NSLog(@"%@",text);
            NSLog(@"%@",self.self.assetModel.tokenId);
            NSLog(@"%@",self.textArray[1].comTextField.text);
            
            [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"asset/transaction" parameters:@{
                            @"address":self.textArray[0].comTextField.text,
                            @"password":[QuickGet encryptPwd:text email:nil],
                            @"tokenId":self.assetModel.tokenId,
                            @"value":@([self.textArray[1].comTextField.text doubleValue])}
                success:^(id responseObject, BOOL isCacheObject)
            {
                if ([responseObject[@"code"] isEqual:@200])
                {
                    [self showSuccessText:@"操作成功"];
                    [TPTransV showMenuWithAlpha:NO];
        
                    [TPNotificationCenter postNotificationName:TPTakeOutSuccessNotification object:nil];
                    for (UIViewController *controller in self.navigationController.viewControllers)
                    {
                        if ([controller isKindOfClass:[TPTokenKindViewController class]])
                        {
                            TPTokenKindViewController *vc = (TPTokenKindViewController *)controller;
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                }
                else
                {
                    [self showErrorText:responseObject[@"message"]];
                }
                [self dismissLoading];
            }
                failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
            {
                [self showErrorText:@"转账失败"];
                [self dismissLoading];
                [TPTransV showMenuWithAlpha:NO];
                NSLog(@"转账失败");
            }];
        }
    }];
}
#pragma mark view logic
- (void)vaildButton {
    self.confirmBtn.userInteractionEnabled = YES;
    [self.confirmBtn setLayer:22 WithBackColor:TPMainColor];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)invaildButton {
    self.confirmBtn.userInteractionEnabled = NO;
    [self.confirmBtn setLayer:22 WithBackColor:TPEBColor];
    [self.confirmBtn setTintColor:TPD5Color];
    
}
@end
