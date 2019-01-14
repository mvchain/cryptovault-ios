//
//  TPSetPasswordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPSetPasswordViewController.h"
#import "TPLoginViewController.h"
@interface TPSetPasswordViewController ()
@property (weak, nonatomic) IBOutlet TPLoginTextView *passWordTextView;
@property (weak, nonatomic) IBOutlet TPLoginTextView *payPassWordTextView;

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
    
    NSArray<TPLoginTextView *> *textViews = @[self.passWordTextView,self.payPassWordTextView];
    for (TPLoginTextView * tpTextView in textViews) {
        [tpTextView noTitleLabel]; // 无提示label
        tpTextView.comTextField.secureTextEntry = YES;
        
    }
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
    
    NSString *passWd = self.passWordTextView.comTextField.text;
    NSString *payPassWd = self.payPassWordTextView.comTextField.text;
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
