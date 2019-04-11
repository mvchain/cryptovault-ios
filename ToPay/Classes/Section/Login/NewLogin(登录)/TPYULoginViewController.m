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
#import "API_POST_User_Salt.h"
#import <GT3Captcha/GT3Captcha.h>
#import "TPLoginGoogleValidViewController.h"
//网站主部署的用于验证登录的接口 (api_1)
#define api_1 @"http://192.168.15.21:10086/user/valid"
//网站主部署的二次验证的接口 (api_2)
#define api_2 @"http://192.168.15.21:10086/user/valid"
@interface TPYULoginViewController ()<GT3CaptchaManagerDelegate>
@property (weak, nonatomic) IBOutlet YUTextView *userNameTextView;
@property (weak, nonatomic) IBOutlet YUTextView *passWdTextView;
@property (weak, nonatomic) IBOutlet YUTextView *vaildCodeTextView;
@property (weak, nonatomic) IBOutlet JKCountDownButton *sendVaildCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (strong, nonatomic) NSDictionary *resDict;
@property (strong, nonatomic) GT3CaptchaManager *manager;
@property (strong, nonatomic) NSDictionary *postDict ;
@property (copy,nonatomic) NSString *mapi_1;
@property (copy,nonatomic) NSString *mapi_2;
@property (assign, nonatomic) BOOL isFirst ;
@property (copy, nonatomic) NSString *hunmanToken ;

@end

@implementation TPYULoginViewController
#pragma mark setter getter
- (GT3CaptchaManager *)manager {
    if (!_manager) {
        _mapi_1 = [QuickGet httpPathWithCurrentServerUrl:@"user/valid"];
        _mapi_2 = [QuickGet httpPathWithCurrentServerUrl:@"user/valid"];
        _manager = [[GT3CaptchaManager alloc] initWithAPI1:api_1 API2:api_2 timeout:5.0];
        _manager.delegate = self;
    }
    return _manager;
}
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
        [self.manager registerCaptcha:^{
        
        }];
    _isFirst = YES;
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
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:kResetPwdType];
    TPResetPassWordGuiderViewController *tp = [[TPResetPassWordGuiderViewController alloc]init];
    [self.navigationController pushViewController:tp animated:YES];
    
}
- (NSArray<YUTextView*> *)textArr {
    return  @[_userNameTextView,_passWdTextView,_vaildCodeTextView];
}
- (void)loginClcik
{
   
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
    API_POST_User_Salt *getSalt = [[API_POST_User_Salt alloc] init];
    getSalt.onSuccess = ^(id responseData) {
        [self loginActionWithSalt:(NSString *)responseData];
    };
    getSalt.onError = ^(NSString *reason, NSInteger code) {
        
    };
    getSalt.onEndConnection = ^{
        
    };
    [getSalt sendRequestWithEmail:self.textArr[0].text];
    
}
- (void)loginActionWithSalt:(NSString *)salt {
    __weak typeof (self) wsf = self;
    //imageToken
    NSDictionary *postDic = @{@"username":self.textArr[0].text,
                              @"password":[QuickGet encryptPwd:self.textArr[1].text salt:salt] ,
                              @"validCode":self.textArr[2].text,
                              } ;
    if (_hunmanToken)
        postDic =  @{@"username":self. textArr[0].text,
                     @"password":[QuickGet encryptPwd:self.textArr[1].text salt:salt] ,
                     @"validCode":self.textArr[2].text,
                     @"imageToken":_hunmanToken
                     } ;
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/login" parameters:postDic
                                              success:^(id responseObject, BOOL isCacheObject)
     {
         
         NSDictionary *respObj = (NSDictionary *)responseObject;
         [self dismissLoading];
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"responseObject:%@",responseObject[@"data"]);
             TPLoginModel *loginM = [TPLoginModel mj_objectWithKeyValues:responseObject[@"data"]];
            
             [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":loginM.token,@"Accept-Language":@"zh-cn"}];
             // Store user information
             
             if (loginM.googleCheck == 1) {
                 // 已经开启Google验证
                 TPLoginGoogleValidViewController *googleVc = [[TPLoginGoogleValidViewController alloc]init];
                 googleVc.loginModel = loginM;
                 [self.navigationController pushViewController:googleVc animated:YES];
             }else {
                 [self showSuccessText:@"登录成功"];
                 [TPLoginUtil loginInitSetting:loginM];
                 [QuickDo swithchToMainTab];
             }
         } else if([responseObject[@"code"] isEqual:@402]) {
             [self api_1_request:^{
                 [self startCaptcha];
             }];
             
         }else
         {
             [self showErrorText:responseObject[@"message"]];
             [self dismissLoading];
         }
         
     }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"error = %@", error);
         [SVProgressHUD showSuccessWithStatus:@"登录失败"];
     }];
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

#pragma mark private method

- (void)startCaptcha {
   
    [self.manager startGTCaptchaWithAnimated:YES];
}
#pragma mark GT3CaptchaManagerDelegate
/**
 *  验证错误处理
 *
 *  @discussion 抛出内部错误, 比如GTWebView等错误
 *
 *  @param manager  验证管理器
 *  @param error    错误源
 */
- (void)gtCaptcha:(GT3CaptchaManager *)manager errorHandler:(GT3Error *)error {
    
}

/**
 *  @abstract 通知已经收到二次验证结果, 在此处理最终验证结果
 *
 *  @discussion
 *  二次验证的错误只在这里返回, `decisionHandler`需要处理
 *
 *  @param manager          验证管理器
 *  @param data             二次验证返回的数据
 *  @param response         二次验证的响应
 *  @param error            错误源
 *  @param decisionHandler  更新验证结果的视图
 */
//- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveSecondaryCaptchaData:(NSData *)data response:(NSURLResponse *)response error:(GT3Error *)error decisionHandler:(void (^)(GT3SecondaryCaptchaPolicy captchaPolicy))decisionHandler {
//    if (!error) {
//        //处理你的验证结果
//        NSLog(@"\ndata: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        //成功请调用decisionHandler(GT3SecondaryCaptchaPolicyAllow)
//        decisionHandler(GT3SecondaryCaptchaPolicyAllow);
//        //失败请调用decisionHandler(GT3SecondaryCaptchaPolicyForbidden)
//        //decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
//    }
//    else {
//        //二次验证发生错误
//        decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
//       // [TipsView showTipOnKeyWindow:error.error_code fontSize:12.0];
//    }
//       // [_delegate captcha:manager didReceiveSecondaryCaptchaData:data response:response error:error];
//}


/**
 *  @abstract 当接收到从<b>API1</b>的数据, 通知返回字典, 包括<b>gt_public_key</b>,
 *  <b>gt_challenge</b>, <b>gt_success_code</b>
 *
 *  @warning 不支持子线程操作。
 *
 *  @discussion
 *  如果实现此方法, 需要解析验证需要的数据并返回。
 如果不返回验证初始化数据, 使用内部的解析规则进行解析。默认先解析一级结构, 再匹配键名为"data"或"gtcap"中的数据。
 *
 *  @param manager      验证管理器
 *  @param dictionary   API1返回的数据(未解析)
 *  @param error        返回的错误
 *
 *  @return 验证初始化数据, 格式见下方
 <pre>
 {
 "challenge" : "12ae1159ffdfcbbc306897e8d9bf6d06",
 "gt" : "ad872a4e1a51888967bdb7cb45589605",
 "success" : 1
 }
 </pre>
 */

// api1 的结果，初始化参数
//
//- (NSDictionary *)gtCaptcha:(GT3CaptchaManager *)manager didReceiveDataFromAPI1:(NSDictionary *)dictionary withError:(GT3Error *)error {
//
//    NSDictionary *resdic = dictionary;
//    NSString *result = resdic[@"data"][@"result"];
//    NSDictionary *resDict = [QuickMaker dictionaryWithJsonString:result];
//    _resDict = resdic;
//    return resDict; // 初始化信息
//
//}
//// API1 拦截
//- (void)gtCaptcha:(GT3CaptchaManager *)manager willSendRequestAPI1:(NSURLRequest *)originalRequest withReplacedHandler:(void (^)(NSURLRequest * request))replacedHandler {
//    NSMutableURLRequest *mRequest = [originalRequest mutableCopy];
//    NSString *newURL = [NSString stringWithFormat:@"%@?email=%@",api_1,self.userNameTextView.text];
//    mRequest.URL = [NSURL URLWithString:newURL];
//    replacedHandler(mRequest);
//}

// api1

- (void)api_1_request:(void(^)(void))complete {
    __weak typeof (self) wsf = self;
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"user/valid"
                                          parameters:@{@"email":self.userNameTextView.text}
                                              success:^(id responseObject, BOOL isCacheObject)
     {
         
         NSDictionary *dictionary = (NSDictionary *)responseObject;
         NSDictionary *resdic = dictionary;
         NSString *result = resdic[@"data"][@"result"];
         NSDictionary *resDict = [QuickMaker dictionaryWithJsonString:result]; // 初始化信息
         wsf.resDict = resdic;
         [wsf.manager configureGTest:resDict[@"gt"] challenge:resDict[@"challenge"] success:resDict[@"success"] withAPI2:api_2];
         
         complete();
         
         
         
     }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
     }];
}

/**
 *  @abstract 通知接收到返回的验证交互结果
 *
 *  @discussion 此方法仅仅是前端返回的初步结果, 并非验证最终结果。
 *
 *  @param manager 验证管理器
 *  @param code    验证交互结果, 0失败/1成功
 *  @param result  二次验证数据
 *  @param message 附带消息
 */
- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveCaptchaCode:(NSString *)code result:(NSDictionary *)result message:(NSString *)message {
    
    if (![result objectForKey:@"geetest_challenge"] && [result objectForKey:@"geetest_seccode"] && [result objectForKey:@"geetest_validate"])
        return;
     
    // 给api2用的 数据
    NSDictionary *post  = @{@"geetest_challenge":result[@"geetest_challenge"],
                  @"geetest_seccode":result[@"geetest_seccode"],
                  @"geetest_validate":result[@"geetest_validate"],
                  @"uid":_resDict[@"data"][@"uid"],
                  @"status":code
                  };
    __weak typeof (self) wsf = self;
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/valid"
                                            parameters:post
                                                                           success:^(id responseObject, BOOL isCacheObject)
     {
         NSDictionary *result = (NSDictionary *) responseObject;
         wsf.hunmanToken = result[@"data"];
         
         int a ;
         
     }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
     }];
}
- (IBAction)onNextTap:(id)sender {
    [self loginClcik];
    
}
- (BOOL)shouldUseDefaultSecondaryValidate:(GT3CaptchaManager *)manager {
    return NO;
}
- (BOOL)shouldUseDefaultRegisterAPI:(GT3CaptchaManager *)manager {
    return NO;
    
}
@end
