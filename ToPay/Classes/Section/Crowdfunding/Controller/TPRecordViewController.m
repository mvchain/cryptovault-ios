//
//  TPRecordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPRecordViewController.h"

@interface TPRecordViewController ()
@property (nonatomic) BOOL isSearch;
@end

@implementation TPRecordViewController

-(TPCrowdfundStyle)type
{
    return TPCrowdfundStyleRecord;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isSearch = NO;
//    self.customNavBar.title = @"众筹记录";
    self.navigationItem.title = @"众筹记录";
    [self showSystemNavgation:YES];

    [self setRightItemImage:@"serch_icon_black"];
    
    
    
    
    [self.view sendSubviewToBack:self.baseTableView];
    
    [self.baseTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
    }];
}

-(void)searchClick
{
    self.isSearch = !self.isSearch;
    if (self.isSearch)
    {
        [self setRightItemImage:@"cancel_icon_black"];
        UITextField *searchText = [YFactoryUI YTextFieldWithPlaceholder:@"搜索众筹项目" color:TPD5Color font:FONT(15) secureTextEntry:NO delegate:nil];
        [searchText addTarget:self action:@selector(didChanegText:) forControlEvents:UIControlEventEditingChanged];
        searchText.frame = CGRectMake(0, 0, KWidth - 95, 36);
        [searchText setLayer:18 WithBackColor:TPF6Color];
        UIImageView *iv = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"serch_icon_black"]];
        iv.size = CGSizeMake(45, 45);
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 200)];//宽度根据需求进行设置，高度必须大于 textField 的高度
        iv.center = lv.center;
        [lv addSubview:iv];
        searchText.leftViewMode = UITextFieldViewModeAlways;
        searchText.leftView = lv;
        
        self.navigationItem.titleView = searchText;
    }
        else
    {
        [self setRightItemImage:@"serch_icon_black"];
        self.navigationItem.titleView = nil;
        self.navigationItem.title = @"众筹记录";
    }
    
    
}

-(void)setRightItemImage:(NSString *)imgName
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:[UIImage imageNamed:imgName] imageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)didChanegText:(UITextField *)textF
{
    NSLog(@"%@",textF.text);
}

- (void)viewWillDisappear:(BOOL)animated {

    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
