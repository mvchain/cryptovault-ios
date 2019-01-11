//
//  TPRegisterViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/11.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPRegisterViewController.h"
#import "TPRgeisterViewModel.h"
@interface TPRegisterViewController ()
@property (strong,nonatomic) TPRgeisterViewModel *viewModel;
@end

@implementation TPRegisterViewController

#pragma mark Lazy Load
// vm
- (TPRgeisterViewModel *)viewModel {
    if( !_viewModel ) {
        _viewModel = [[TPRgeisterViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark View Method

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
