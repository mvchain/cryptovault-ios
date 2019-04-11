//
//  TPLoginGoogleValidViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/9.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPLoginGoogleValidViewController.h"
#import "YUTextView.h"
#import "API_POST_User_Google.h"
@interface TPLoginGoogleValidViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet YUTextView *codeTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end

@implementation TPLoginGoogleValidViewController

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];

    [self setUpUI];
}
#pragma mark - <public method>

#pragma mark - <private method>
- (void)setNav {
    self.customNavBar.title = @"登录";
}

- (void)setUpUI {
    [self.loginButton gradualChangeStyle];
    self.codeTextView.xibContainer.textField.placeholder = @"输入Google验证码";
    self.codeTextView.xibContainer.textField.keyboardType = UIKeyboardTypeNumberPad;
    
}
#pragma mark - <event response>

- (IBAction)loginTap:(id)sender {
    
    API_POST_User_Google *checkoutGoogleCode = [[API_POST_User_Google alloc] init];
    checkoutGoogleCode.token = self.loginModel.token;
    checkoutGoogleCode.onSuccess = ^(id responseData) {
        TPLoginModel *loginM = [TPLoginModel mj_objectWithKeyValues:responseData];
        [TPLoginUtil loginInitSetting:loginM];
        [QuickDo swithchToMainTab];
    };
    
    checkoutGoogleCode.onError = ^(NSString *reason, NSInteger code) {
        [self showErrorText:reason];
    };
    checkoutGoogleCode.onEndConnection = ^{
    
    };
    [checkoutGoogleCode sendRequestWithGoogleCode:@(self.codeTextView.text.integerValue)];
}
#pragma mark - <lazy load>

@end
