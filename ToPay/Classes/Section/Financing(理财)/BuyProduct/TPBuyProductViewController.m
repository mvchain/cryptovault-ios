//
//  TPBuyProductViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBuyProductViewController.h"
#import "TPTransView.h"
@interface TPBuyProductViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_view_top;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *productNumberLabel;
@end
@implementation TPBuyProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setUpNav];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    [_submitButton gradualChangeStyle];
    NSString *tipStr = TPString(@"产品限额：%ld/%ld",self.productModel.purchased,self.productModel.limitValue) ;
    
    self.inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.productNumberLabel setText:tipStr];
    [self.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self setTipLabelDefault];
    self.atly_view_top.constant = self.customNavBar.height+12;
    

}
- (void)setTipLabelDefault {
    NSString *balanceStr = TPString(@"可用%@:%.4lf",self.productModel.baseTokenName,self.productModel.balance);
    [self.tipLabel setText:balanceStr];
    [self.tipLabel setTextColor:[UIColor colorWithHex:@"#8E8E9E"]];
}
- (void)setTipLabelWaring {
    NSString *balanceStr = TPString(@"可用%@不足",self.productModel.baseTokenName);
    [self.tipLabel setText:balanceStr];
    [self.tipLabel setTextColor:[UIColor colorWithHex:@"#F33636"]];
}
- (void)textFieldDidChange:(id)sender {
    UITextField *senderText=(UITextField *)sender;
    if ([senderText.text floatValue] >self.productModel.balance) {
        [self setTipLabelWaring];
    }else {
         [self setTipLabelDefault];
    }
}
- (IBAction)savInTap:(id)sender {
    TPTransView *transView = [TPTransView createTransferViewStyle:TPTransStyleTakeOut];
    transView.title = @"确认存入";
    transView.desc = @"总计需支付";
    
    transView.Total = TPString(@"%@ %@",self.inputTextField.text,self.productModel.baseTokenName);
    [transView showMenuWithAlpha:YES];
    
    __weak typeof (transView) w_tran = transView;
    [transView.pasView setEndEditBlock:^(NSString *text) {
        if (text.length == 6) {
            [self buyProduct:text value:[self.inputTextField.text intValue] ];
            [w_tran showMenuWithAlpha:NO];
        }
    }];
}
- (void)buyProduct:(NSString *)transPwd value:(NSInteger)num {
    ///financial/{id}
    
    NSDictionary *postDidct = @{@"transactionPassword":[QuickGet encryptPwd:transPwd email:nil],@"value":@(num)};
    NSString *url = TPString(@"financial/%ld",self.productModel.idField);
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer
                                                 url:url
                                          parameters:postDidct
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     [self showSuccessText:@"存入成功！"];
                                                     [self.navigationController popViewControllerAnimated:YES];
                                                 }else {
                                                     [self showErrorText:TPString(@"错误:%@",res[@"message"])];
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 [self showErrorText:@"网络错误"];
                                             } ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.inputTextField becomeFirstResponder];
}
- (void)setUpNav {
    self.customNavBar.title = TPString(@"%@ 存入",self.productModel.name);
}

@end
