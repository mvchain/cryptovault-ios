//
//  TPFilterViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/26.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPFilterViewController.h"
#import "GBTagListView.h"
#import "TPVRTModel.h"
@interface TPFilterViewController ()
@property (nonatomic, strong) GBTagListView *tagListCate;
@property (nonatomic, strong) GBTagListView *tagListVRT;
@property (nonatomic, strong) GBTagListView *tagListBalance;
@end

@implementation TPFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"筛选";
    
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    

    NSArray *balanceArr = (NSArray *)[listCache objectForKey:TPPairBalanceKey];
    NSArray *VRTArr = (NSArray *)[listCache objectForKey:TPPairVRTKey];
    
    
    NSMutableArray *balanceTitle = [NSMutableArray array];
    for (int i = 0 ; i < balanceArr.count; i++)
    {
        TPVRTModel *VRTM = balanceArr[i];
        [balanceTitle addObject:VRTM.tokenName];
    }
    
    NSMutableArray *VRTTitle = [NSMutableArray array];
    for (int i = 0 ; i < VRTArr.count; i++)
    {
        TPVRTModel *VRTM = VRTArr[i];
        [VRTTitle addObject:VRTM.tokenName];
    }
    
    [self createFilterViewWithBalance:balanceTitle WithVRT:VRTTitle];
    [self createBottomBtn];
}


-(void)createBottomBtn
{
    UIButton *reservationBtn = [YFactoryUI YButtonWithTitle:@"确认" Titcolor:[UIColor whiteColor] font:FONT(15) Image:nil target:self action:@selector(reservationClick)];
    [reservationBtn setLayer:22 WithBackColor:TPMainColor];
    [self.view addSubview:reservationBtn];
    
    [reservationBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(-(56 + HOME_INDICATOR_HEIGHT));
         make.width.equalTo(@343);
         make.height.equalTo(@44);
     }];
}

-(void)createFilterViewWithBalance:(NSArray *)balanceArr WithVRT:(NSArray *)VRTArr
{
    UILabel *cateLab = [self createLabelWithTitle:@"类型" WithTop:16 + StatusBarAndNavigationBarHeight];
    CGFloat margin = 5;
    _tagListCate = [self createTagListViewWithContent:@[@"全部",@"买入",@"卖出"] WithFrame:CGRectMake(margin, cateLab.bottom + 11, KWidth, 100)];
    
    [_tagListCate setDidselectItemBlock:^(NSArray *arr)
     {
         NSLog(@"arr1:%@",arr);
     }];
    [_tagListCate setDidSelectIndex];
    
    
    UILabel *VRTLab = [self createLabelWithTitle:@"VRT交易" WithTop:_tagListCate.bottom + 13];
    
    _tagListVRT = [self createTagListViewWithContent:balanceArr WithFrame:CGRectMake(margin, VRTLab.bottom + 11, KWidth, 100)];
    [_tagListVRT setDidselectItemBlock:^(NSArray *arr)
     {
         NSLog(@"arr2:%@",arr);
     }];
    
    UILabel *balanceLab = [self createLabelWithTitle:@"余额交易" WithTop:_tagListVRT.bottom + 13];
    
    _tagListBalance = [self createTagListViewWithContent:VRTArr WithFrame:CGRectMake(margin, balanceLab.bottom + 11, KWidth, 100)];
    [_tagListBalance setDidselectItemBlock:^(NSArray *arr)
     {
         NSLog(@"arr3:%@",arr);
     }];
}

-(GBTagListView *)createTagListViewWithContent:(NSArray *)conArray WithFrame:(CGRect)frame
{
   GBTagListView *tagListView = [[GBTagListView alloc] initWithFrame:frame];
    /** 允许点击 */
    tagListView.canTouch = YES;
    /**控制允许点击的标签数 */
    tagListView.canTouchNum = 0;
    /**控制是否是单选模式 */
    tagListView.isSingleSelect = YES;
    [tagListView setMarginBetweenTagLabel:8 AndBottomMargin:13];
    tagListView.signalTagColor = [UIColor colorWithHex:@"#EBF1FB"];
    [tagListView setTagWithTagArray:conArray];
    [self.view addSubview:tagListView];
    return tagListView;
}

-(UILabel *)createLabelWithTitle:(NSString *)title WithTop:(CGFloat)top
{
    UILabel *Lab = [YFactoryUI YLableWithText:title color:TP59Color font:FONT(13)];
    [self.view addSubview:Lab];
    Lab.left = 20;
    Lab.top = top;
    Lab.width = 100;
    Lab.height = 17;
    return Lab;
}

-(void)reservationClick
{
    NSLog(@"确认");
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"transaction/partake" parameters:@{@"id":@"0",
                      @"pageSize":@"10",
                      @"pairId":@"",
                      @"status":@"",
                      @"transactionType":@"",
                      @"type":@""} success:^(id responseObject, BOOL isCacheObject)
    {
        
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
