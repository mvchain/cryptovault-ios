//
//  TPWebViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/12.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPWebViewController.h"

@interface TPWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end

@implementation TPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUp {
    self.customNavBar.title = @"详情";
    self.top.constant = self.customNavBar.height;
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
   
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
