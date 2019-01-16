//
//  TPSetPasswordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPSetPasswordViewController.h"
#import "TPLoginViewController.h"
#import "YUTextView.h"
#import "TPMnemonicDisplayViewController.h"
@interface TPSetPasswordViewController ()
@property (weak, nonatomic) IBOutlet YUTextView *passWordTextView;
@property (weak, nonatomic) IBOutlet YUTextView *payPassWordTextView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;

@end

@implementation TPSetPasswordViewController
#pragma mark lazy load
- (TPSetPasswordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TPSetPasswordViewModel alloc] init];
    }
    return _viewModel;
}
- (void)initUI {
    
    NSArray<YUTextView *> *textViews = @[self.passWordTextView,self.payPassWordTextView];
    NSArray *titles = @[@"登陆密码",@"支付密码"];
    int index = 0 ;
    for (YUTextView *textView in textViews) {
        [textView setHintText:titles[index]];
        [textView setPlaceHolder:titles[index]];
        textView.xibContainer.textField.secureTextEntry = YES;
        index++;
    }
    [self.nextStepButton gradualChangeStyle]; // 渐变
    
}
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark custom method

#pragma mark event method

/**
 * 下一步按钮
 *
 */
- (IBAction)onNextStepTap:(id)sender {
    
    NSString *passWd = self.passWordTextView.text;
    NSString *payPassWd = self.payPassWordTextView.text;
    self.viewModel.regInfoModel.password = passWd;
    self.viewModel.regInfoModel.transactionPassword = payPassWd;
    
    [self.viewModel isPassWordVaildWithPassWd:passWd payPassWd:payPassWd
                                  quickResult:^(BOOL isVaild, NSString *reasonInf) {
                                      if (isVaild) {
                                          // 输入格式合法
                                          // 开始向服务器注册
                                          [self.viewModel registerWithRegInfoModel:self.viewModel.regInfoModel complete:^(BOOL isSucc, NSString *_reasonInfo) {
                                              if (isSucc) {
                                                  [self showSuccessText:@"注册成功"];
                                                  TPMnemonicDisplayViewController *mn = [[TPMnemonicDisplayViewController alloc]init];
                                                  [self.navigationController pushViewController:mn animated:YES];
                                              }else {
                                                  [self showErrorText:_reasonInfo];
                                              }
                                          }];
                                      }else {
                                          [self showErrorText:reasonInf];
                                      }
    }];
}

@end
