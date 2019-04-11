//
//  TPMVCBankViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/3.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPMVCBankViewController.h"
#import "TPMVCBanTableViewController.h"
#import "API_GET_Transaction_Pair.h"
#import "TPPair.h"
#import "MVCBankCoinSelectView.h"
#import "MVCBankSelectListCellEntity.h"
#import "TPMVCBankSelectListView.h"
#import "API_GET_Transaction_Pair_Tickers.h"
#import "TPBuyRecordViewController.h"
#import "TPSellViewController.h"
@interface TPMVCBankViewController ()<SGPageContentScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIView *switchBgView;
@property (weak, nonatomic) IBOutlet UIView *headerBgView;
@property (strong, nonatomic) NSMutableArray<TPPair *> *pairs ;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (strong,nonatomic) MVCBankCoinSelectView *coinSelectView ;
@property (strong,nonatomic) TPMVCBankSelectListView *selectListView ;
@property (strong,nonatomic) UIButton *black ;
@property (assign,nonatomic) BOOL isShowBlackNow;
@property (strong,nonatomic) TPPair *curPair ;
@property (assign,nonatomic) BOOL isCoinSelectState;
@property (strong,nonatomic) TPMVCBanTableViewController  *buy;
@property (strong,nonatomic) TPMVCBanTableViewController  *sell;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchView;
@property (weak, nonatomic) IBOutlet UILabel *curPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *highPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowPriceLabel;


@end
@implementation TPMVCBankViewController
#pragma mark lazy_load
yudef_lazyLoad(NSMutableArray<TPPair *>, pairs, _pairs);
yudef_lazyLoad(UIButton,black,_black);
#pragma mark init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    [self setUpEvent];
    [self refreshData] ;
}

- (void)setUpPageContentView
{
    _buy = [[TPMVCBanTableViewController alloc] init];
    _sell = [[TPMVCBanTableViewController alloc] init];
    NSArray *childArr = @[_buy, _sell];
    [self.view layoutIfNeeded];
    self.pageContentScrollView = [[SGPageContentScrollView alloc]initWithFrame:CGRectMake(0, _switchBgView.bottom , KWidth, KHeight -_switchBgView.bottom)
                                                                      parentVC:self
                                                                    childVCs:childArr];
    _buy.transactionType = 1;
    _sell.transactionType = 2;
    
    self.pageContentScrollView.delegatePageContentScrollView = self;
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:0];
    [self.view addSubview:_pageContentScrollView];
   
    
}

- (void)setUp {
    self.customNavBar.title =@"MVC交易";
    [self.top setConstant:self.customNavBar.height+5];
    [self setUpPageContentView];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    [self.switchBgView yu_smallCircleStyle];
    [self.headerBgView yu_smallCircleStyle];
    _coinSelectView = [MVCBankCoinSelectView xib_loadUsingClassName];
    if (iPhoneX) {
         [_coinSelectView setFrame:CGRectMake(0, 45, 75, 44)];
    }else {
         [_coinSelectView setFrame:CGRectMake(0, 20, 75, 44)];
    }
   
    [self.customNavBar addSubview:_coinSelectView];
    _selectListView = [TPMVCBankSelectListView xib_loadUsingClassName];
    
}

- (void)refreshData {
    API_GET_Transaction_Pair *getTransatcionPair  = [[API_GET_Transaction_Pair alloc] init];
    getTransatcionPair.onSuccess = ^(id responseData) {
        NSArray *arr =(NSArray *)responseData;
        for (NSDictionary *dict in arr) {
            TPPair *pair = [[TPPair alloc]initWithDictionary:dict];
            [self.pairs addObject:pair];
        }
        if (arr.count >0)  {
            self.curPair = self.pairs[0];
        }
    };
    getTransatcionPair.onError = ^(NSString *reason, NSInteger code) {
        
    };
    getTransatcionPair.onEndConnection = ^{
        
    };
    [getTransatcionPair sendRequestWithPairType:@(1)];
}
#pragma mark view logic

- (void)showBlack {
    [self.black setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self.black setFrame:CGRectMake(0, self.customNavBar.height, KWidth, KHeight-self.customNavBar.height)];
    [self.view addSubview:self.black];
    _isShowBlackNow = YES;
}

- (void)hideBlack {
    [self.black removeFromSuperview];
    _isShowBlackNow = NO;
}
- (void)hideSelectView {
    
    [self hideBlack];
    [self.selectListView removeFromSuperview];
    
}
- (void)showSelectView {
    [self showBlack];
    [self.view addSubview:self.selectListView];
}
#pragma mark event
- (void)setUpEvent {
    yudef_weakSelf;
    // curPair change
    [self bk_addObserverForKeyPath:@"curPair" task:^(id target) {
        [weakSelf.coinSelectView.titleLabel setText:weakSelf.curPair.tokenName];
        
       [ @[weakSelf.buy,weakSelf.sell] bk_each:^(id obj) {
           
          TPMVCBanTableViewController *tableVc = (TPMVCBanTableViewController *)obj;
           tableVc.curPair = weakSelf.curPair;
           [tableVc refresh];
           
        }];
        // 24h 信息
        API_GET_Transaction_Pair_Tickers *getTicker = [[API_GET_Transaction_Pair_Tickers alloc]init];
        getTicker.onSuccess = ^(id responseData) {
            
            if ([responseData isKindOfClass:[NSNull class]]) return ;
            NSDictionary *dict = (NSDictionary *)responseData;
            CGFloat high = [dict[@"high"] doubleValue];
            CGFloat low = [dict[@"low"] doubleValue];
            CGFloat cur = [dict[@"price"] doubleValue];
            [self.highPriceLabel setText:TPString(@"%.8f",high)];
            [self.lowPriceLabel setText:TPString(@"%.8f",low)];
            [self.curPriceLabel setText:TPString(@"%.8f",cur)];
            
        };
        getTicker.onError = ^(NSString *reason, NSInteger code) {
            
        };
        getTicker.onEndConnection = ^{
            
        };
        [getTicker sendRequestWithPairId:@(weakSelf.curPair.pairId)];
        
    }];
    
    [self.black addTarget:self action:@selector(blackTap:) forControlEvents:UIControlEventTouchUpInside];
    // 切换货币类型 按下
    self.coinSelectView.tap = ^(id  _Nonnull sender)
    {
        weakSelf.isCoinSelectState = YES;
        if (weakSelf.isShowBlackNow) {
            [weakSelf hideSelectView];
            
        }else {
         
            weakSelf.selectListView.frame = CGRectMake(0, weakSelf.customNavBar.height , KWidth, 44 * weakSelf.pairs.count);
            NSMutableArray *listDatas = [[NSMutableArray alloc] init];
            for (TPPair *pair in weakSelf.pairs) {
                MVCBankSelectListCellEntity *entity = [[MVCBankSelectListCellEntity alloc] init];
                entity.title = pair.tokenName;
                entity.data = pair;
                [listDatas addObject:entity];
            }
            weakSelf.selectListView.arrays = listDatas;
            [weakSelf showSelectView];
            [weakSelf.selectListView refresh];
        }
    };
    
    // 最顶上右边按钮按下
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"trade-mvc_icon"]];
    self.customNavBar.onClickRightButton = ^{
        weakSelf.isCoinSelectState = NO;
        if (weakSelf.isShowBlackNow) {
            [weakSelf hideSelectView];
            
        }else {
            weakSelf.selectListView.frame = CGRectMake(0, weakSelf.customNavBar.height , KWidth, 44 *3);
            NSMutableArray *listDatas = [[NSMutableArray alloc] init];
            NSArray *titles = @[@"买入MVC挂单",@"卖出MVC挂单",@"交易记录"];
            for (int i=0;i<titles.count;i++) {
                MVCBankSelectListCellEntity *entity = [[MVCBankSelectListCellEntity alloc] init];
                entity.title = titles[i];
                [listDatas addObject:entity];
            }
            weakSelf.selectListView.arrays = listDatas;
            [weakSelf showSelectView];
            [weakSelf.selectListView refresh];
        }
    };
    
    // 顶部弹出列表 按下
    self.selectListView.tap = ^(NSInteger index) {
         [weakSelf hideSelectView];
        if (weakSelf.isCoinSelectState) {
           
            weakSelf.curPair = weakSelf.pairs[index];
            
        }else {
            switch (index) {
                case 0:
                {
                    TPSellViewController *sell = [[TPSellViewController alloc] initWithPairId:@(weakSelf.curPair.pairId).stringValue WithTransType:TPTransactionTypeTransfer publish:YES];
                    sell.curPair = weakSelf.curPair;
                    [weakSelf.navigationController pushViewController:sell animated:YES];
                }
                    break;
                case 1:
                {
                    TPSellViewController *sell = [[TPSellViewController alloc] initWithPairId:@(weakSelf.curPair.pairId).stringValue WithTransType:TPTransactionTypeTransferOut publish:YES];
                    sell.curPair = weakSelf.curPair;
                    [weakSelf.navigationController pushViewController:sell animated:YES];
                    
                }
                     break;
                case 2:
                {
                    TPBuyRecordViewController *record = [[TPBuyRecordViewController alloc] init];
                    [weakSelf.navigationController pushViewController:record animated:YES];
                }
                     break;
                default:
                    break;
            }
        }
    };
    [self.switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    
    [@[_buy,_sell] bk_each:^(id obj) {
        ((TPMVCBanTableViewController *)obj).onListTap = ^(TPTransactionModel * _Nonnull transModel) {
            int transType = obj == weakSelf.buy?1:2;
            TPSellViewController *sellVC = [[TPSellViewController alloc] initWithPairId:TPString(@"%ld",(long)weakSelf.curPair.pairId)  WithTransType:transType publish:NO];
            sellVC.currName = weakSelf.curPair.tokenName;
            sellVC.curPair = weakSelf.curPair;
            sellVC.transModel = transModel;
            sellVC.isFromTableView = YES;
            [self.navigationController pushViewController:sellVC animated:YES];
        };
    }];
    
}

- (void)switchChange:(UISegmentedControl *)sender {
    
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:sender.selectedSegmentIndex];

}

- (void)blackTap:(id)sender {

      [self hideBlack];
      [self.selectListView removeFromSuperview];
}
#pragma mark delegate
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    self.switchView.selectedSegmentIndex = targetIndex;
}
@end

