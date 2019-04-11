//
//  TPGoogleValidWelcomeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/9.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPGoogleValidWelcomeViewController.h"
#import "YUAlertViewController.h"
#import "TPGoogleSecurityValidViewController.h"
@interface TPGoogleValidWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation TPGoogleValidWelcomeViewController

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.startButton gradualChangeStyle];
    [self setNav];
    [self navEventSetting];
}

#pragma mark - <public method>

#pragma mark - <private method>
- (void)setNav {
    self.customNavBar.title = @"账户安全";
    [self.customNavBar wr_setRightButtonWithTitle:@"跳过"
                                       titleColor:[UIColor colorWithHex:@"#333333"]];
    [self.customNavBar.rightButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
}
#pragma mark - <event response>
- (void)navEventSetting {
    yudef_weakSelf;
    self.customNavBar.onClickRightButton = ^{
        YUAlertViewController *alert  = [[YUAlertViewController alloc]init];
        [alert yu_setting:^(YUAlertViewControllerConfirmOnlyStyle *style) {
            style.yu_alertTitle = @"";
            style.yu_alertContent = @"跳过后，您可以在账户安全里开启Google验证";
            style.yu_confirmButtonTitle = @"我知道了";
        } confirmAction:^(id sender) {
            [QuickDo swithchToMainTab];
            
            
            
        }];
        [weakSelf presentViewController:alert animated:YES completion:^{
            
        }];
        
    };
}
- (IBAction)enableNow:(id)sender {
    TPGoogleSecurityValidViewController *googleSecurity = [[TPGoogleSecurityValidViewController alloc] init];
    [self.navigationController pushViewController:googleSecurity animated:YES];
}
#pragma mark - <lazy load>


@end
