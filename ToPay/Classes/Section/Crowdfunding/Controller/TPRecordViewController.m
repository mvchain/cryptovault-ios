//
//  TPRecordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPRecordViewController.h"
#import "YUSearchBarView.h"
#import "UIView+SGPagingView.h"
@interface TPRecordViewController ()
@property (nonatomic) BOOL isSearch;
@property (nonatomic, assign)BOOL isSearchState ;
@property (nonatomic, strong)YUSearchBarView *searchbar;
@end
@implementation TPRecordViewController
- (YUSearchBarView *)searchbar {
    if( !_searchbar ) {
        _searchbar = [YUSearchBarView SG_loadViewFromXib];
        _searchbar.placeholder = @"搜索项目名称";
    }
    return _searchbar;
}
-(TPCrowdfundStyle)type
{
    return TPCrowdfundStyleRecord;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isSearch = NO;
    self.isSearchState = NO;
//    self.customNavBar.title = @"众筹记录";
//    self.navigationItem.title = @"众筹记录";
    [self showSystemNavgation:NO];
   // [self setRightItemImage:@"serch_icon_black"];
    [self.view sendSubviewToBack:self.baseTableView];
    [self.baseTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
    }];
    [self setupNavigation];
    [self setEvent];
    
    
}
-(void)setupNavigation
{
    //    [self showSystemNavgation:YES];
    //    self.navigationItem.title = @"添加币种";
    self.customNavBar.title = @"添加币种";
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightClick) image:[UIImage imageNamed:@"serch_icon_black"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_black"]];
    __weak typeof (self) wsf = self;
    [self.customNavBar setOnClickRightButton:^
     {
        // [wsf reBackUpSearchResult] ; // 重置搜索
         YUSearchBarView * search  = wsf.searchbar;
         if( !wsf.isSearchState ) {
             //当前非搜索状态，点击后变成搜索状态
             [wsf.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"cancel_icon_black"]];
             [wsf.customNavBar addSubview:search];
             search.searchTextfield.text = @"";
             [search setHeight:36.0];
             [search setWidth:wsf.customNavBar.width - 90];
             [search setCenterY:wsf.customNavBar.leftButton.centerY];
             [search setCenterX:wsf.customNavBar.centerX];
             [search tobeCircle]; // 圆角
             [search.searchTextfield becomeFirstResponder];
             [search fadeIn:^{

             }];
         }else{
             // 当前搜索状态，点击后变非搜索状态
             [search.searchTextfield resignFirstResponder];
             [search fadeOut:^{
                 [wsf.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_black"]];
                 [wsf.searchbar removeFromSuperview];
             }];
         }
         wsf.isSearchState = !wsf.isSearchState; // 切换状态
         [wsf.baseTableView reloadData];
     }];
}

- (void)setEvent {
    __weak typeof (self) wsf = self;
    self.searchbar.onTextChange = ^(NSString *text) {
        wsf.projectNmae = text;
    };
    self.searchbar.onTextDidEndEditing = ^(id sender) {
        wsf.customNavBar.onClickRightButton(); // end editing , end searching ...
        wsf.projectNmae = @"";
        
    };
    self.searchbar.onTextKeyboardReturn = ^(NSString *text) {
        [wsf loadNewTopics];
        
    };
    
    
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
