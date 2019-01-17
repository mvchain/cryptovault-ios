//
//  TPRegisterViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/11.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRegisterViewController.h"
#import "TPRgeisterViewModel.h"
#import "TPLoginViewController.h"
#import "JKCountDownButton.h"
#import "TPSetPasswordViewController.h"
#import "YUTextView.h"

@interface TPRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton; // 下一步按钮
@property (weak, nonatomic) IBOutlet YUTextView *invitedCodeTextView; // 邀请码文本框
@property (weak, nonatomic) IBOutlet YUTextView *nickNameTextView; // 昵称文本框
@property (weak, nonatomic) IBOutlet YUTextView *emailTextView; // 邮箱文本框
@property (weak, nonatomic) IBOutlet YUTextView *vaildCodeTextView; // 验证码文本框
@property (weak, nonatomic) IBOutlet JKCountDownButton *sendVaildCodeButton; // 发送验证码按钮


@property (strong,nonatomic) TPRgeisterViewModel *viewModel;
@property (copy, nonatomic) NSString *invitedCodeStr; // 邀请码字符串
@property (copy, nonatomic) NSString *nickNameStr; //昵称字符串
@property (copy, nonatomic) NSString *emailStr; // emial字符串
@property (copy, nonatomic) NSString *vaildCodeStr; // 验证码字符串

@end

@implementation TPRegisterViewController

#pragma mark lazy Load
// vm
- (TPRgeisterViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[TPRgeisterViewModel alloc] init];
    }
    return _viewModel;
}
- (NSString *)invitedCodeStr {
    return self.invitedCodeTextView.text;
}
- (NSString *)nickNameStr {
    return self.nickNameTextView.text;
}
- (NSString *)emailStr {
    return self.emailTextView.text;
}
- (NSString *)vaildCodeStr {
    return self.vaildCodeTextView.text;
}
#pragma mark initialize
- (void)initUI {
    
    NSArray<YUTextView *> *textViews = @[_invitedCodeTextView,_nickNameTextView,_emailTextView,_vaildCodeTextView];
    NSArray *titles = @[@"邀请码",@"昵称",@"邮箱",@"验证码"];
    NSArray *placeholders = @[@"注册邀请码",@"设置昵称",@"输入邮箱",@"输入验证码"];
    NSInteger index = 0;
    self.invitedCodeTextView.xibContainer.textField.keyboardType =  UIKeyboardTypeASCIICapable;
    self.emailTextView.xibContainer.textField.keyboardType = UIKeyboardTypeEmailAddress;
    self.vaildCodeTextView.xibContainer.textField.keyboardType = UIKeyboardTypeNumberPad;
    for( YUTextView *textView in textViews ) {
        [textView setHintText:titles[index]];
        [textView setPlaceHolder:placeholders[index]];
        index++;
    }
    [self.sendVaildCodeButton rectBlackBorderStyle];
}
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.nextStepButton gradualChangeStyle];
    
}
#pragma mark local method
/**
 * 验证码动画
 */
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

/** 
 * 发送验证码
 */
- (IBAction)onSendVaildCodeTap:(id)sender {
  
    if ( self.emailTextView.text.length > 0 ) {
        [self startValidCodeButtonAnimate];//
        [self.viewModel sendVaildCodeByEmail:self.emailTextView.text
                                    complete:^(BOOL isSucc) {
                                        if (isSucc) {
                                            [self showSuccessText:@"发送成功!"];
                                        }else {
                                            [self showErrorText:@"发送失败！"];
                                        }
                                    }];
    } else {
        [self showSuccessText:@"邮箱不可以为空"];
    }
}

/**
 * 点击下一步
 */
- (IBAction)onNextTap:(id)sender {
    self.viewModel.regInfoModel.email = self.emailStr;
    self.viewModel.regInfoModel.inviteCode = self.invitedCodeStr;
    self.viewModel.regInfoModel.nickname = self.nickNameStr;
    
    [self.viewModel isRegisterParameterCorrect:self.invitedCodeStr
                                      nickName:self.nickNameStr
                                         email:self.emailStr
                                     vaildCode:self.vaildCodeStr
                                   quickResult:^(BOOL isVaild, NSString *resonInf)
    {
        if (isVaild) {
            // 输入内容格式合法
            [TProgressHUD showLoading];
            [self.viewModel userWithEmail:self.emailStr
                               inviteCode:self.invitedCodeStr
                                vaildCode:self.vaildCodeStr
                                 complete:^(BOOL isSucc, NSString *token, NSString *message)
            {
                if (isSucc) {
                    TPSetPasswordViewController *setPassVc = [[TPSetPasswordViewController alloc] init];
                    setPassVc.viewModel.regInfoModel = self.viewModel.regInfoModel; // 传递注册信息
                    [self.navigationController pushViewController:setPassVc animated:YES];//跳转
                }else {
                    [self showSuccessText:message];
                }
                [TProgressHUD dismissLoading];
            }];
                                           
        }else {
            [self showErrorText:resonInf]; // 提示不合法理由
        }
    }];
    
}


@end
