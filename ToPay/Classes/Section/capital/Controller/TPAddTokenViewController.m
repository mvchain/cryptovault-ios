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

@property (nonatomic, strong) NSMutableArray *addTokenIdArr;
@property (nonatomic, strong) NSMutableArray *removeTokenIdArr;
//@property (nonatomic, copy) NSMutableString *addToken, *removeToken;
@end

@implementation TPAddTokenViewController

static NSString  *TPAddTokenCellId = @"addTokenCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.addTokenIdArr = [NSMutableArray array];
    self.removeTokenIdArr = [NSMutableArray array];
//    self.addToken = [[NSMutableString alloc] init];
//    self.removeToken = [[NSMutableString alloc] init];
//    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer url:@"asset" parameters:@{@"addTokenIdArr":@"",@"removeTokenIdArr":@""} success:^(id responseObject, BOOL isCacheObject)
//    {
//        if ([responseObject[@"code"] isEqual:@200])
//        {
////            NSLog(@"%@");
//
////            self.assetTopic = [TPAssetModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
////            [self.baseTableView reloadData];
//        }
//    }
//        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
//    {
//        NSLog(@"修改币种失败");
//    }];
    
    self.assetNameArr = [NSMutableArray array];
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
    
}

-(void)setupNavigation
{
    self.customNavBar.title = @"添加币种";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_1"]];
    [self.customNavBar setOnClickRightButton:^
     {
         NSLog(@"搜索");
     }];
    
    TPWeakSelf
    
//    NSString *printStr2 = @"321321";//[[NSString alloc] init];
//    [printStr2 stringByAppendingString:@"hhhhh"];
//    NSLog(@"<<<<<<<<<<<<<%@>\n<>>>>>>>>>>>>>>",printStr2);
    
//    NSArray *array = [NSArray arrayWithObjects:@"Hello",@" ",@"world", @"!", nil];
//    NSString *printStr = @"";
//    for(int i = 0; i < [array count]; i++){
//        printStr = [printStr stringByAppendingFormat:@"%@", [array objectAtIndex:i]];
//    }
//    NSLog(@"第一种方法%@", printStr);
    NSString *printStr2 = @"";
    
    [self.customNavBar setOnClickLeftButton:^
     {
         

         
//         for (int i = 0 ; i < self.addTokenIdArr.count; i++)
//         {
////             [weakSelf.addToken stringByAppendingFormat:@"%@",[weakSelf.addTokenIdArr objectAtIndex:i]];
//             NSLog(@"addTokenIdArr：%@",[weakSelf.addTokenIdArr objectAtIndex:i]);
//         }
         
         for (int a = 0 ; a < self.removeTokenIdArr.count; a++)
         {
//             [weakSelf.removeToken stringByAppendingFormat:@"%@",[weakSelf.removeTokenIdArr objectAtIndex:a]];
             NSLog(@"%@",weakSelf.removeTokenIdArr[a]);
             
         }
//         weakSelf.removeToken
         [printStr2 stringByAppendingString:@"hhhhh"];
//         NSLog(@"<<<<<<<<<<<<<%@>\n<>>>>>>>>>>>>>>",printStr2);
         
         [weakSelf.navigationController popViewControllerAnimated:YES];
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
    
    cell.operatingBlock = ^(BOOL isAdd, NSString *tokenId)
    {
        if (isAdd == YES)
        {
            if ([self.addTokenIdArr containsObject:tokenId])
            {
                [self.addTokenIdArr removeObject:tokenId];
            }
            
            [self.removeTokenIdArr addObject:tokenId];
        }
            else
        {
            if ([self.removeTokenIdArr containsObject:tokenId])
            {
                [self.removeTokenIdArr removeObject:tokenId];
            }
            
            [self.addTokenIdArr addObject:tokenId];
        }
    };
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
