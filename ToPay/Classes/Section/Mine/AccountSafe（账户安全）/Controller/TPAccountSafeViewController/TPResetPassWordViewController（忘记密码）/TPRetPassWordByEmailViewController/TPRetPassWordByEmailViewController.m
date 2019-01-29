//
//  TPRetPassWordByEmailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRetPassWordByEmailViewController.h"
#import "YUTextView.h"
#import "JKCountDownButton.h"
#import "TPResetPassWordByEmailViewModel.h"
#import "TPRestPasswordViewModel.h"
#import "TPResetPwdOneTextFiledViewController.h"

@interface TPRetPassWordByEmailViewController ()
@property (weak, nonatomic) IBOutlet YUTextView *emaiTextView;
@property (weak, nonatomic) IBOutlet YUTextView *vaildTextView;
@property (weak, nonatomic) IBOutlet JKCountDownButton *sendVaildCode;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (strong, nonatomic) TPResetPassWordByEmailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet JKCountDownButton *sendVaildEmialButton;
@end

@implementation TPRetPassWordByEmailViewController
#pragma mark lazy load
- (TPResetPassWordByEmailViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[TPResetPassWordByEmailViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark system methdo
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.scrollerView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0);
    self.emaiTextView.xibContainer.textField.placeholder = @"邮箱";
    [self.emaiTextView setHintText:@"邮箱"];
    [self.vaildTextView setHintText:@"验证码"];
    [self.vaildTextView setPlaceHolder:@"验证码"];
    [self.nextStepButton gradualChangeStyle];
    [self.sendVaildEmialButton rectBlackBorderStyle];
    self.vaildTextView.xibContainer.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.emaiTextView.xibContainer.textField.keyboardType = UIKeyboardTypeEmailAddress;
    
}

#pragma mark local method
- (void)startValidCodeButtonAnimate {
    [self.sendVaildEmialButton startCountDownWithSecond:60];
    self.sendVaildEmialButton.enabled = NO;
    [self.sendVaildEmialButton rectGrayBorderStyle];
    [self.sendVaildEmialButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        self.sendVaildEmialButton.enabled = YES;
        [self.sendVaildEmialButton rectBlackBorderStyle];
        return @"发送验证码";
    }];
}

#pragma event
- (IBAction)onSendVaildTap:(id)sender {
    [self startValidCodeButtonAnimate];
    if (self.emaiTextView.text.length == 0) {
        [self showErrorText:@"邮箱不可为空"];
        return;
    }
    [self.viewModel sendVaildCodeByEmail:self.emaiTextView.text
                                complete:^(BOOL isSucc) {
                                    if (isSucc) {
                                        [self showSuccessText:@"发送成功"];
                                    }else {
                                        [self showSuccessText:@"发送失败"];
                                    }
                                }];
}

- (IBAction)onNextStepTap:(id)sender {
    if(self.vaildTextView.text.length == 0) {
        [self showErrorText:@"验证码不能为空"];
        return;
        
    }
    [self.viewModel resetWithEmail:self.emaiTextView.text
                         vaildCode:self.vaildTextView.text
                          complete:^(BOOL isSucc, NSString *info) {
                              if (isSucc) {
                                  TPResetPwdOneTextFiledViewController *tp = [[TPResetPwdOneTextFiledViewController alloc] init];
                                  TPRestPasswordViewModel *model = [[TPRestPasswordViewModel alloc] init];
                                  model.onceToken = self.viewModel.onceToken;
                                  tp.viewModel = model;
                                  [self.navigationController pushViewController:tp animated:YES];
                              }else {
                                  [self showErrorText:TPString(@"验证失败:%@",info)];
                              }
    }];
}

@end
