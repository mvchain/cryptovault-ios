//
//  TPGoogleSecurityValidViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/8.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPGoogleSecurityValidViewController.h"
#import "API_GET_User_Google.h"
#import "TPEnableGoogleValidViewController.h"
#import "NIMScanner.h"
@interface TPGoogleSecurityValidViewController ()
@property (weak, nonatomic) IBOutlet UILabel *secretKeyLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;

@end

@implementation TPGoogleSecurityValidViewController

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUpUI];
    [self setData];
    
}

#pragma mark - <public method>

#pragma mark - <private method>
- (void)setNav {
    self.customNavBar.title = @"Google安全验证";
}
- (void)setUpUI{
      [self.nextButton gradualChangeStyle];
    self.nextButton.enabled = NO;
}
- (void)setData {
    
    API_GET_User_Google *getGoogleInfo = [[API_GET_User_Google alloc]init];
    getGoogleInfo.onSuccess = ^(id responseData) {
        NSDictionary *resDict = (NSDictionary *)responseData;
        NSString *secret = resDict[@"secret"];
        [self.secretKeyLabel setText:secret];
        self.nextButton.enabled = YES;
        [NIMScanner qrImageWithString:resDict[@"otpAuthURL"] avatar:nil
                           completion:^(UIImage *image)
         {
             self.QRImageView.image = image;
         }];

    };
    getGoogleInfo.onError = ^(NSString *reason, NSInteger code) {
        
    };
    getGoogleInfo.onEndConnection = ^{
        
    };
    [getGoogleInfo sendRequest];
    
    
}
#pragma mark - <event response>

- (IBAction)nextTap:(id)sender {
    TPEnableGoogleValidViewController *vc = [[TPEnableGoogleValidViewController alloc] init];
    vc.status = 1;
    vc.googleSecret = self.secretKeyLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)copySecretTap:(id)sender {
    [QuickDo copyToPastboard:self.secretKeyLabel.text];
    [self showSuccessText:@"已复制"];
}


#pragma mark - <lazy load>

@end
