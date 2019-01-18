//
//  TPResetPassWordGuiderViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPResetPassWordGuiderViewController.h"
#import "TPRetPassWordByEmailViewController.h"
#import "TPResetPwdOneTextFiledViewController.h"
#import "TPRestPasswordViewModel.h"
#import "TPRestPasswordByMnmonicViewModel.h"
#import "TPRestPasswordByPrivateKeyViewModel.h"
@interface TPResetPassWordGuiderViewController ()
@property (weak, nonatomic) IBOutlet UIButton *emailReseButton;
@property (weak, nonatomic) IBOutlet UIButton *privateKeyReset;
@property (weak, nonatomic) IBOutlet UIButton *mnmeoincButton;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation TPResetPassWordGuiderViewController
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [_emailReseButton gradualChangeStyle];
    [_privateKeyReset gradualChangeStyle];
    [_mnmeoincButton gradualChangeStyle];
     self.scrollView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0);
}

- (IBAction)onEmailTap:(id)sender {
    TPRetPassWordByEmailViewController *tp  = [[TPRetPassWordByEmailViewController alloc] init];
    [self.navigationController pushViewController:tp animated:YES];

}

- (IBAction)onPrivteKeyTap:(id)sender {
    TPResetPwdOneTextFiledViewController *tp = [[TPResetPwdOneTextFiledViewController alloc] init];
    TPRestPasswordByPrivateKeyViewModel *model = [[TPRestPasswordByPrivateKeyViewModel alloc] init];
    tp.viewModel = model;
    [self.navigationController pushViewController:tp animated:YES];
}

- (IBAction)onMnmeoicTap:(id)sender {
    TPResetPwdOneTextFiledViewController *tp = [[TPResetPwdOneTextFiledViewController alloc] init];
    TPRestPasswordByMnmonicViewModel *model = [[TPRestPasswordByMnmonicViewModel alloc] init];
    tp.viewModel = model;
    [self.navigationController pushViewController:tp animated:YES];
}

@end
