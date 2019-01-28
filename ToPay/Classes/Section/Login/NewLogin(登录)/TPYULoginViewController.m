//
//  TPYULoginViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPYULoginViewController.h"
#import "TPRgeisterViewModel.h"
#import "TPLoginViewController.h"
#import "JKCountDownButton.h"
#import "TPSetPasswordViewController.h"
#import "YUTextView.h"
#import "YUTabBarController.h"
#import "TPResetPassWordGuiderViewController.h"
#import "TPRgeisterViewModel.h"
@interface TPYULoginViewController ()
@property (weak, nonatomic) IBOutlet YUTextView *userNameTextView;
@property (weak, nonatomic) IBOutlet YUTextView *passWdTextView;
@property (weak, nonatomic) IBOutlet YUTextView *vaildCodeTextView;
@property (weak, nonatomic) IBOutlet JKCountDownButton *sendVaildCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;

@end

@implementation TPYULoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<YUTextView *> *textViews = @[_userNameTextView,_passWdTextView,_vaildCodeTextView];
    NSArray *titles = @[@"邮箱",@"密码",@"验证码"];
    NSInteger index = 0;
    _userNameTextView.xibContainer.textField.keyboardType = UIKeyboardTypeEmailAddress;
    _passWdTextView.xibContainer.textField.secureTextEntry = YES;
    _vaildCodeTextView.xibContainer.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    for( YUTextView *textView in textViews ) {
        [textView setHintText:titles[index]];
        [textView setPlaceHolder:titles[index]];
        index++;
    }
    [self.sendVaildCodeButton rectBlackBorderStyle];
    [self.nextStepButton gradualChangeStyle];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)onforgetTap:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"reset-pwd-type"];
    TPResetPassWordGuiderViewController *tp = [[TPResetPassWordGuiderViewController alloc]init];
    [self.navigationController pushViewController:tp animated:YES];
    
}
- (NSArray<YUTextView*> *)textArr {
    return  @[_userNameTextView,_passWdTextView,_vaildCodeTextView];
}
-(void)loginClcik
{
      NSString * str = [QuickGet encryptPwd:self.textArr[1].text email:self. textArr[0].text];
    //[SVProgressHUD show];
    [self showLoading];
    
    if (self.textArr[1].text.length == 0)
    {
        [self showInfoText:@"密码不能为空"];
        return ;
    }
    
    if (self.textArr[2].text.length <= 0)
    {
        [self showInfoText:@"请输入正确的验证码"];
        return ;
    }
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/login" parameters:@{@"username":self. textArr[0].text,
                                                                                                             @"password":[QuickGet encryptPwd:self.textArr[1].text email:self. textArr[0].text] ,
                                                                                                             @"validCode":self.textArr[2].text,
                                                                                                             } success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"responseObject:%@",responseObject[@"data"]);
             TPLoginModel *loginM = [TPLoginModel mj_objectWithKeyValues:responseObject[@"data"]];
             // set Request token
             [QuickDo setJPushAlians:loginM.userId];
             [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":loginM.token,@"Accept-Language":@"zh-cn"}];
             // Store user information
             [TPLoginUtil saveUserInfo:loginM];
             // Basic user information
             [TPLoginUtil setRequestInfo];
             // Get currency list
             [TPLoginUtil setRequestToken];
             [TPLoginUtil requestExchangeRate];
             [self showSuccessText:@"登录成功"];
             [SVProgressHUD showSuccessWithStatus:@"登录成功"];
             UIApplication *app = [UIApplication sharedApplication];
             AppDelegate *dele = (AppDelegate*)app.delegate;
             dele.window.rootViewController = [[YUTabBarController alloc] config];
         }
         else
         {
             [self showErrorText:responseObject[@"message"]];
             [self dismissLoading];
         }
         [self dismissLoading];
     }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"error = %@", error);
         [SVProgressHUD showSuccessWithStatus:@"登录失败"];
     }];
    
}

- (IBAction)onNextTap:(id)sender {
    [self loginClcik];
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

/**
 * 发送验证码
 */

- (IBAction)onSendVaildCodeTap:(id)sender {
    if ( self.userNameTextView.text.length > 0 ) {
        [self startValidCodeButtonAnimate];//
        TPRgeisterViewModel *sModel = [[TPRgeisterViewModel alloc] init];
        
        [sModel sendVaildCodeByEmail:self.userNameTextView.text
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
