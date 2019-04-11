//
//  TPAddTokenViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//
#import "YUSearchBarView.h"
#import "TPAddTokenViewController.h"
#import "TPAddTokenCell.h"
#import "TPCurrencyList.h"
#import "UIView+SGPagingView.h"
#import "PHJTransformPinyin.h"
@interface TPAddTokenViewController ()
@property (nonatomic, strong) TPCurrencyList *currencyList;
@property (nonatomic, strong) YUSearchBarView *searchbar;
@property (nonatomic, strong) NSMutableArray *assetNameArr;
@property (nonatomic, strong) NSMutableArray *addTokenIdArr;
@property (nonatomic, strong) NSMutableArray *removeTokenIdArr;
@property (nonatomic, strong) NSMutableArray *searchResult;

@property (assign,nonatomic) BOOL isSearchState;

//@property (nonatomic, copy) NSMutableString *addToken, *removeToken;
@end

@implementation TPAddTokenViewController

static NSString  *TPAddTokenCellId = @"addTokenCell";
#pragma mark lazy_load
- (YUSearchBarView *)searchbar {
    if( !_searchbar ) {
        _searchbar = [YUSearchBarView SG_loadViewFromXib];
        _searchbar.placeholder = @"搜索币种";
    }
    return _searchbar;
}
- (NSMutableArray *)searchResult {
    if( !_searchResult ) {
        _searchResult = [[NSMutableArray alloc]init];
        
    }
    return _searchResult;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addTokenIdArr = [NSMutableArray array];
    self.removeTokenIdArr = [NSMutableArray array];
    self.assetNameArr = [NSMutableArray array];
    self.isSearchState = NO;
    for (int i = 0 ; i < self.assetTopic.count; i++)
    {
        TPAssetModel *asset = self.assetTopic[i];
        [self.assetNameArr addObject:asset.tokenName];
    }
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    self.currencyList = (TPCurrencyList *)[listCache objectForKey:TPCurrencyListKey];
    [self setupNavigation];
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@(StatusBarAndNavigationBarHeight));
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(@(KHeight - StatusBarAndNavigationBarHeight));
     }];
    
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
        [wsf reBackUpSearchResult] ; // 重置搜索
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

-(void)rightClick
{
    NSLog(@"搜索");
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( _isSearchState ) {
        return self.searchResult.count;
    }else {
        return self.currencyList.data.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPAddTokenCell *cell = [tableView dequeueReusableCellWithIdentifier:TPAddTokenCellId];
   
    if (!cell)
        cell = [[TPAddTokenCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPAddTokenCellId withfilterData:self.assetNameArr];
    if( _isSearchState ) {
        cell.clData =  self.searchResult[indexPath.row];
        
    }else {
        cell.clData =  self.currencyList.data[indexPath.row];
    }
    __block TPAddTokenCell *addTokenCell = cell;
    
    cell.operatingBlock = ^(BOOL isAdd, NSString *tokenId, NSString * tokenName)
    {
        [self operatingCurrencyIsAdd:isAdd WithTokenId:tokenId WithName:tokenName WithSelectCell:addTokenCell];
    };
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - 添加 移除 币种事件
-(void)operatingCurrencyIsAdd:(BOOL)isAdd WithTokenId:(NSString *)tokenId WithName:(NSString *)tokenName WithSelectCell:(TPAddTokenCell *)cell
{
    if (isAdd == NO)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:TPString(@"确定移除%@?",tokenName) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
          {
              cell.isRemoveToken = YES;
              [self sendTokenClcikAdd:@"" removeToken:tokenId];
          }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //添加顺序和显示顺序相同
        [alertController addAction:cancelAction];
        [alertController addAction:resetAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return ; 
    }
        else
    {
        [self sendTokenClcikAdd:tokenId removeToken:@""];
    }
}


-(void)sendTokenClcikAdd:(NSString *)addToken removeToken:(NSString *)removeToken
{
    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer url:@"asset" parameters:@{@"addTokenIdArr":addToken,@"removeTokenIdArr":removeToken} success:^(id responseObject, BOOL isCacheObject)
       {
           if ([responseObject[@"code"] isEqual:@200])
           {
               
               [TPNotificationCenter postNotificationName:TPPutCurrencyNotification object:nil];

               NSLog(@"修改币种成功");
           }
       }
           failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
       {
//           NSLog(@"修改币种失败");
           [SVProgressHUD showErrorWithStatus:@"修改币种操作失败,请稍后尝试"];
       }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
#pragma mark block event
- (void)setEvent {
    __weak typeof (self) wsf = self;
    self.searchbar.onTextChange = ^(NSString *text) {
        [wsf reBackUpSearchResult];
        NSPredicate *pre = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            CLData *data = (CLData *)evaluatedObject;
            NSString *key =  [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            key = [key uppercaseString];
            key = [key stringByReplacingOccurrencesOfString:@" " withString:@""]; // remove space
            if( [key isEqualToString:@""] ) return YES;
            if( [data.tokenName containsString:key] ) {
                return YES;
            }
            if( [data.tokenCnName containsString:key] ) {
                return YES;
            }
            if( [data.tokenEnName containsString:key] ) {
                return YES;
            }
            NSString *tkpinyin = [[data.tokenCnName transformToPinyin] uppercaseString];
            tkpinyin = [tkpinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
            if( [tkpinyin  containsString:key] ) {
                return YES;
            }
            return  NO;
        }];
        [wsf.searchResult filterUsingPredicate:pre];
        [wsf.baseTableView reloadData];
    };
    self.searchbar.onTextDidEndEditing = ^(id sender) {
        wsf.customNavBar.onClickRightButton(); // end editing , end searching ...
    };
}
#pragma mark logic function
- (void)reBackUpSearchResult {
    self.searchResult = [[NSMutableArray alloc]init];
    for( CLData *data in self.currencyList.data ) {
        [self.searchResult addObject:data];
    }
}
-(void)dealloc
{
    [TPNotificationCenter removeObserver:self];
}
@end
