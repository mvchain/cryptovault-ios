//
//  YUBlockDetailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/13.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBlockDetailViewController.h"

@interface YUBlockDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *pageListView;
@end

@implementation YUBlockDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    // Do any additional setup after loading the view from its nib.
}
- (void)setNav {
    self.customNavBar.title = @"区块详情";
    
}


@end
