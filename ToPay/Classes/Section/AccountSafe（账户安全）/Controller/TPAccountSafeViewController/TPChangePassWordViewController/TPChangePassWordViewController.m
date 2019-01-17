//
//  TPChangePassWordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPChangePassWordViewController.h"
#import "YUTextView.h"
@interface TPChangePassWordViewController ()
@property (weak, nonatomic) IBOutlet YUTextView *passWordTextView;
@property (weak, nonatomic) IBOutlet YUTextView *confirPassWordTextView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation TPChangePassWordViewController

#pragma mark system method 
- (void)viewDidLoad {
    [super viewDidLoad];
    NSAssert(self.viewModel !=nil, @"ViewModel 必须存在！");
    self.scrollView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0);
    
    self.passWordTextView.xibContainer.textField.placeholder = TPString(@"输入当前%@",self.viewModel.passWordTypeName);
    self.confirPassWordTextView.xibContainer.textField.placeholder = TPString(@"输入新%@",self.viewModel.passWordTypeName);
}

@end
