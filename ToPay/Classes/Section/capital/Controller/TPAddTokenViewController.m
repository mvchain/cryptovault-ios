//
//  TPAddTokenViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPAddTokenViewController.h"
#import "TPAddTokenCell.h"
#import "TPCurrencyList.h"
@interface TPAddTokenViewController ()
@property (nonatomic, strong)TPCurrencyList *currencyList;
@property (nonatomic, strong) NSMutableArray *assetNameArr;
@end

@implementation TPAddTokenViewController

static NSString  *TPAddTokenCellId = @"addTokenCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.assetNameArr = [NSMutableArray array];
    
    for (int i = 0 ; i < self.assetTopic.count; i++)
    {
        TPAssetModel *asset = self.assetTopic[i];
        [self.assetNameArr addObject:asset.tokenName];
    }
    
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    
    self.currencyList = (TPCurrencyList *)[listCache objectForKey:TPCurrencyListKey];
    
    
    self.customNavBar.title = @"添加币种";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_1"]];
    [self.customNavBar setOnClickRightButton:^
    {
        NSLog(@"搜索");
    }];
    
   
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@(StatusBarAndNavigationBarHeight));
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(@(KHeight - StatusBarAndNavigationBarHeight));
     }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currencyList.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPAddTokenCell *cell = [tableView dequeueReusableCellWithIdentifier:TPAddTokenCellId];
    if (!cell)
        cell = [[TPAddTokenCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPAddTokenCellId withfilterData:self.assetNameArr];
    cell.clData = self.currencyList.data[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
