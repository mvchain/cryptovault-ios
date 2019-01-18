//
//  TPChangePassWordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPChangePassWordViewController.h"
#import "TPResetPassWordGuiderViewController.h"
#import "TPChangePassWordViewModel_PayPassWd.h"
#import "TPChangePassWordViewModel_LoginPassWd.h"
#import "YUTextView.h"
@interface TPChangePassWordViewController ()
@property (weak, nonatomic) IBOutlet YUTextView *passWordTextView;
@property (weak, nonatomic) IBOutlet YUTextView *mnewPassWordTextView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation TPChangePassWordViewController

#pragma mark system method 
- (void)viewDidLoad {
    [super viewDidLoad];
    NSAssert(self.viewModel !=nil, @"ViewModel 必须存在！");
    self.scrollView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0);
    self.customNavBar.title = TPString(@"修改%@",self.viewModel.passWordTypeName);
    NSString *current = TPString(@"输入%@",self.viewModel.passWordTypeName);
    NSString *newOne = TPString(@"输入新%@",self.viewModel.passWordTypeName);
    self.passWordTextView.xibContainer.textField.placeholder = current;
    self.passWordTextView.xibContainer.textField.keyboardType = self.viewModel.textFieldKeyboardType;
    self.mnewPassWordTextView.xibContainer.textField.placeholder = newOne;
    self.mnewPassWordTextView.xibContainer.textField.keyboardType = self.viewModel.textFieldKeyboardType;
    [self.passWordTextView setHintText: current];
    [self.mnewPassWordTextView setHintText:newOne];
    [self.nextStepButton gradualChangeStyle];
}

#pragma mark event method

- (IBAction)onForgetPassWdTap:(id)sender {
    if ([self.viewModel isKindOfClass:TPChangePassWordViewModel_PayPassWd.class]) {
         [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"reset-pwd-type"];
    }else {
         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"reset-pwd-type"];
    }
    TPResetPassWordGuiderViewController *tp = [[TPResetPassWordGuiderViewController alloc] init];
    [self.navigationController pushViewController:tp animated:YES];
    
}
- (IBAction)onConfirmChangeTap:(id)sender {
    
    if (self.passWordTextView.text.length == 0) {
        [self showErrorText:@"旧密码不能为空"];
        return;
    }
    if (self.mnewPassWordTextView.text.length == 0) {
        [self showErrorText:@"新密码不能为空"];
        return;
    }
    [self.viewModel changePassWdWithOldPassWd:self.passWordTextView.text
                                    newPassWd:self.mnewPassWordTextView.text
                                     complete:^(BOOL isSucc, NSString *info) {
                                         if (isSucc) {
                                             [self showSuccessText:@"修改成功"];
                                             [QuickDo logout];
                                         }else {
                                             [self showErrorText:TPString(@"修改失败:%@",info)];
                                         }
    }];
}
@end
