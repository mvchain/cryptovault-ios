//
//  TPVerifyEmailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBindEmailViewController.h"
#import "YUTextView.h"
#import "JKCountDownButton.h"

@interface TPBindEmailViewController ()

@property (weak, nonatomic) IBOutlet YUTextView *emailTextView;
@property (weak, nonatomic) IBOutlet YUTextView *vaildCodeTextView;
@property (weak, nonatomic) IBOutlet JKCountDownButton *sendVaildCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation TPBindEmailViewController
#pragma mark lazy Load
// vm
- (TPBindEmailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TPBindEmailViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
#pragma mary local method
- (void)initUI {
    [self.sendVaildCodeButton rectBlackBorderStyle];
    [self.confirmButton gradualChangeStyle];
    self.customNavBar.title = @"绑定新邮件";
    _emailTextView.xibContainer.textField.keyboardType = UIKeyboardTypeEmailAddress;
    _vaildCodeTextView.xibContainer.textField.keyboardType = UIKeyboardTypeNumberPad;
    NSArray<YUTextView *> *viewArr = @[_emailTextView,_vaildCodeTextView];
    NSArray *titles = @[@"新邮箱",@"邮箱验证码"];
    NSInteger index = 0;
    for (NSString *title in titles) {
        [viewArr[index] setHintText:title];
        [viewArr[index] setPlaceHolder:title];
        index++;
    }
    self.scrollView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0  );
    self.customNavBar.title = @"绑定新邮箱";
}
- (void)startValidCodeButtonAnimate {
    [self.sendVaildCodeButton startCountDownWithSecond:60];
    self.sendVaildCodeButton.enabled = NO;
    [self.sendVaildCodeButton rectGrayBorderStyle];
    [self.sendVaildCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        self.sendVaildCodeButton.enabled = YES;
        [self.sendVaildCodeButton rectBlackBorderStyle];
        return @"发送验证码";
    }];
}
#pragma mark event method

- (IBAction)onSendVaildCodeTap:(id)sender {
    
    if (self.emailTextView.text == 0 ) {
        [self showErrorText:@"邮箱不能为空"];
        return;
    }
    
    if (![JudegeCenter isAvailableEmail:self.emailTextView.text]) {
        [self showErrorText:@"邮箱格式不正确"];
        return;
    }

    [self startValidCodeButtonAnimate];
    [self.viewModel sendVaildCodeByEmail:self.emailTextView.text
                                complete:^(BOOL isSucc) {
        if (isSucc) {
            [self showSuccessText:@"发送成功"];
        }else {
            [self showSuccessText:@"发送失败"];
        }
    }];
}

- (IBAction)onNextStep:(id)sender {
    
    if(self.vaildCodeTextView.text.length == 0) {
        [self showErrorText:@"验证码不能为空"];
        return;
    }
    [self.viewModel rebindEmail:self.emailTextView.text
                          token:self.viewModel.oneceToken
                       valiCode:self.vaildCodeTextView.text
                       complete:^(BOOL isSucc, NSString *info) {
                           if (isSucc) {
                               [self showSuccessText:@"绑定成功"];
                               [TPLoginUtil  quitWithRemoveUserInfo];
                               [QuickDo switchToGuiderPage];
                           }else {
                               [self showErrorText:TPString(@"绑定失败:%@",info)];
                           }
    }];
    
}
@end
