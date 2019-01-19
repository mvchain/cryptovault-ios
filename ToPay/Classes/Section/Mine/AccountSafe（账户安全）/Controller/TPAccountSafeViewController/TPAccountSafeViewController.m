//
//  TPAccountSafeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPAccountSafeViewController.h"
#import "TPAccountSafeViewModel.h"
#import "TPBindEmailViewController.h"
#import "TPChangePassWordViewController.h"
#import "TPVerifyViewController.h"
#import "TPChangePassWordViewModel_LoginPassWd.h"
#import "TPChangePassWordViewModel_PayPassWd.h"
@interface TPAccountSafeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) TPAccountSafeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_tableview_top;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TPAccountSafeViewController
#pragma mark lazy load
- (TPAccountSafeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TPAccountSafeViewModel alloc]init];
    }
    return _viewModel;
}
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    self.atly_tableview_top.constant = self.customNavBar.height;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    self.tableView.scrollEnabled = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.viewModel.dataArrays];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56.0;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [QuickDo prettyTableViewCellSeparate:@[@2] cell:cell indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TPVerifyViewController *verifyVc = [[TPVerifyViewController alloc] init];
        [self.navigationController pushViewController:verifyVc animated:YES];
    }
    if (indexPath.row == 1) {
        TPChangePassWordViewController *change = [[TPChangePassWordViewController alloc] init];
        change.viewModel = [[TPChangePassWordViewModel_LoginPassWd alloc] init];

        [self.navigationController pushViewController:change animated:YES];
    }
    if (indexPath.row == 2) {
        TPChangePassWordViewController *change = [[TPChangePassWordViewController alloc] init];
        change.viewModel = [[TPChangePassWordViewModel_PayPassWd alloc] init];
        [self.navigationController pushViewController:change animated:YES];
    }
}

#pragma mark local method
- (void)setUpNav {
    
    self.customNavBar.title = @"账户安全";
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
