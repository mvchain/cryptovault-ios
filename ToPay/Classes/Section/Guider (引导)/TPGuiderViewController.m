//
//  TPGuiderViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPGuiderViewController.h"
#import "TPLoginViewController.h"
#import "TPRegisterViewController.h"
#import "TPGuiderViewModel.h"
#import "TPSetPasswordViewModel.h"
#import "TPMnemonicDisplayViewController.h"
#import "UIButton+YUButtonStyle.h"
@interface TPGuiderViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIImageView *wlecomeImageView;
@property (strong, nonatomic) TPGuiderViewModel *viewModel;

@end

@implementation TPGuiderViewController
#pragma mark lazy load
- (TPGuiderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TPGuiderViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark initialize
- (void)setUp {
    
}
- (void)setUpNav {
    
}

#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.loginButton allWhiteStyle];
    [self.registerButton whiteBorderStyle];
    
}
#pragma mark local method

#pragma mark event
- (IBAction)onLoginTap:(id)sender {
    TPLoginViewController *loginVc = [[TPLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}
- (IBAction)onRegisterTap:(id)sender {
    
    TPRegisterResponseModel *reg_responseModel = [self.viewModel cacheRegResponseModel]; // 有注册返回信息，说明注册已成功，只是没激活
    
    if (reg_responseModel) {
        TPMnemonicDisplayViewController *mnemonicVc = [[TPMnemonicDisplayViewController alloc]init];
        [self.navigationController pushViewController:mnemonicVc animated:YES];
        
    }else {
        TPRegisterViewController *regVc = [[TPRegisterViewController alloc] init];
        [self.navigationController pushViewController:regVc animated:YES];
    }
 
}



@end
