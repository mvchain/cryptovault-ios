//
//  TPEnableGoogleValidViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/9.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPEnableGoogleValidViewController.h"
#import "YUTextView.h"
#import "YUAlertViewController.h"
#import "API_PUT_User_Google.h"
@interface TPEnableGoogleValidViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet YUTextView *loginPasswordTextView;
@property (weak, nonatomic) IBOutlet YUTextView *googleValidCodeTextView;
@end
@implementation TPEnableGoogleValidViewController

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - <public method>

#pragma mark - <private method>
- (void)setNav {
    self.customNavBar.title = @"Google安全验证";
}
- (void)setData {
    
}
- (void)setUpUI{
    [self.startButton gradualChangeStyle];
    self.loginPasswordTextView.xibContainer.textField.placeholder = @"输入登录密码";
    self.googleValidCodeTextView.xibContainer.textField.placeholder = @"输入Google验证码";
    self.googleValidCodeTextView.xibContainer.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.loginPasswordTextView.xibContainer.textField.secureTextEntry = YES;
    if (self.status == 1) {
        [self.startButton setTitle:@"开启Google验证" forState:UIControlStateNormal];
        
    }else {
         [self.startButton setTitle:@"关闭Google验证" forState:UIControlStateNormal];
    }
    
}
#pragma mark - <event response>

- (IBAction)enableGoogleVaildTap:(id)sender {
    if (self.loginPasswordTextView.xibContainer.textField.text.length == 0 ||
        self.googleValidCodeTextView.xibContainer.textField.text.length == 0) {
        [self showErrorText:@"请填写完整！"];
        return;
    }
    API_PUT_User_Google *putUserGoogle = [[API_PUT_User_Google alloc] init];
    putUserGoogle.onSuccess = ^(id responseData) {
        TPLoginModel *loginM = [TPLoginModel mj_objectWithKeyValues:responseData];
        [TPLoginUtil loginInitSetting:loginM];

        YUAlertViewController *alert = [[YUAlertViewController alloc]init];
        [alert yu_setting:^(YUAlertViewControllerConfirmOnlyStyle *style) {
            style.yu_alertTitle = @"提示";
            NSArray  *contents = @[@"解绑成功！",@"绑定成功！"];
            style.yu_alertContent = contents[self.status];
          
            style.yu_confirmButtonTitle = @"我知道了";
        } confirmAction:^(id sender) {
             [QuickDo swithchToMainTab];
        }];
        [self presentViewController:alert animated:YES completion:^{
           
        }];
        
       
    };
    putUserGoogle.onError = ^(NSString *reason, NSInteger code) {
        [self showErrorText:reason];
        
    };
    putUserGoogle.onEndConnection = ^{
        
    };
    NSString *password = [QuickGet encryptPwd:self.loginPasswordTextView.text salt:nil];
    [putUserGoogle sendRequestWithPassword:password
                                    status:@(self.status)
                                googleCode:@(self.googleValidCodeTextView.text.integerValue)
                              googleSecret:self.googleSecret];
    
}
#pragma mark - <lazy load>

@end
