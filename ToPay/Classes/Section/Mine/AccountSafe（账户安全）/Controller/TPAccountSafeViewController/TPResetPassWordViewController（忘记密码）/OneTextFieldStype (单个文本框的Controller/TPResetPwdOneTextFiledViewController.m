//
//  TPResetPwdOneTextFiledViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPResetPwdOneTextFiledViewController.h"
#import "YUTextView.h"
#import "TPRestPasswordViewModel.h"
#import "TPRestPasswordByMnmonicViewModel.h"
#import "TPRestPasswordByPrivateKeyViewModel.h"
#import "TPMnemonicSettingViewController.h"
#import "TPMnemonicSettingViewModel_ResetPassWd.h"
#import "TPResetPasswordByPrivatekey_InputEmailVM.h"
@interface TPResetPwdOneTextFiledViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet YUTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TPResetPwdOneTextFiledViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSAssert(self.viewModel, @"viewmodel --- 必须存在");
    self.descLabel.text = self.viewModel.HintTitle;
    [self.textView setHintText:self.viewModel.placeHolder];
    [self.textView setPlaceHolder:self.viewModel.placeHolder];
    self.textView.xibContainer.textField.keyboardType = self.viewModel.keyboardType;
    [self.submitButton setTitle:self.viewModel.buttonTitle forState:UIControlStateNormal];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0);
    [self.submitButton gradualChangeStyle];
    self.textView.xibContainer.textField.secureTextEntry = self.viewModel.isPasswdType;
    // Do any additional setup after loading the view from its nib.
}
#pragma mark tap
- (IBAction)onSubmitTap:(id)sender {
    if (self.textView.text.length == 0) {
        [self showErrorText:@"请填写完整"];
        return ;
    }
    [self.viewModel submitWithValue:self.textView.text
                           complete:^(BOOL isSucc, NSString *info,id data) {
                               if (isSucc) {
                                   if ([self.viewModel isKindOfClass:TPRestPasswordViewModel.class]) {
                                       // 修改密码
                                       [self showSuccessText:@"重置成功"];
                                       if ([[[NSUserDefaults standardUserDefaults]objectForKey:kResetPwdType] isEqualToString:@"1"]) {
                                            [QuickDo logout]; //退出
                                       }else {
                                           [self.navigationController popToRootViewControllerAnimated:YES];
                                           
                                       }
                                   }else if ( [self.viewModel isKindOfClass:TPRestPasswordByPrivateKeyViewModel.class ]) {
                                       // 私钥重置第二阶段
                                       TPRestPasswordViewModel *rmodel = [[TPRestPasswordViewModel alloc]init];
                                       rmodel.onceToken = ((TPRestPasswordByPrivateKeyViewModel *)self.viewModel).onceToken;
                                       TPResetPwdOneTextFiledViewController *cv = [[TPResetPwdOneTextFiledViewController alloc]init];
                                       cv.viewModel = rmodel;
                                       [self.navigationController pushViewController:cv animated:YES];
                                       
                                   } else if( [self.viewModel isKindOfClass:TPResetPasswordByPrivatekey_InputEmailVM.class] ) {
                                       // 私钥重置第一阶段
                                       TPRestPasswordByPrivateKeyViewModel *vm = [[TPRestPasswordByPrivateKeyViewModel alloc] init];
                                       TPResetPwdOneTextFiledViewController *cv = [[TPResetPwdOneTextFiledViewController alloc]init];
                                       cv.viewModel = vm;
                                       [self.navigationController pushViewController:cv animated:YES];
                                   }
                                   else if ([self.viewModel isKindOfClass:TPRestPasswordByMnmonicViewModel.class]) {
                                       // 助记词，第一阶段
                                       TPMnemonicSettingViewController *tp  =[[TPMnemonicSettingViewController alloc] init];
                                       TPMnemonicSettingViewModel_ResetPassWd *resetModel = [[TPMnemonicSettingViewModel_ResetPassWd alloc] init];
                                       [resetModel setDownDataArraysByArr:data];
                                       resetModel.emialAddr = self.textView.text;
                                       tp.viewModel = resetModel;
                                       [self.navigationController pushViewController:tp animated:YES];
                                   }
                               }
                               else {
                                   [self showErrorText:TPString(@"%@",info)];
                               }
    }];
}

@end
