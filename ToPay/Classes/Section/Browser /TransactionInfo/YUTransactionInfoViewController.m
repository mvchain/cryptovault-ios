//
//  YUTransactionInfoViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTransactionInfoViewController.h"
#import "YUPageListView.h"
#import "API_GET_Block_Transaction_Tx_Hash.h"
#import "BrowserTransactionInfoModel.h"
#import "YUItemLeftRightCellEntity.h"
@interface YUTransactionInfoViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;
@end

@implementation YUTransactionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.atly_top.constant = self.customNavBar.height + 5;
    [self configListView];
    [self.pageListView beginRefreshHeader];
    // Do any additional setup after loading the view from its nib.
}

- (void)configListView  {
    yudef_weakSelf;
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        API_GET_Block_Transaction_Tx_Hash *GET_Block_Transaction_Tx_Hash = [[API_GET_Block_Transaction_Tx_Hash alloc] init];
        GET_Block_Transaction_Tx_Hash.onSuccess = ^(id responseData) {
            NSDictionary *dict = (NSDictionary *)responseData;
            BrowserTransactionInfoModel *model = [[BrowserTransactionInfoModel alloc] initWithDictionary:dict];
            YUItemLeftRightCellEntity *hash = [[YUItemLeftRightCellEntity alloc]init];
            YUItemLeftRightCellEntity *transTime = [[YUItemLeftRightCellEntity alloc]init];
            YUItemLeftRightCellEntity *confirm = [[YUItemLeftRightCellEntity alloc]init];
            YUItemLeftRightCellEntity *transValue = [[YUItemLeftRightCellEntity alloc]init];
            YUItemLeftRightCellEntity *recepitAddr = [[YUItemLeftRightCellEntity alloc]init];
            YUItemLeftRightCellEntity *transferAddr = [[YUItemLeftRightCellEntity alloc]init];
            YUItemLeftRightCellEntity *blockHeight = [[YUItemLeftRightCellEntity alloc]init];
            hash.leftStr = @"交易Hash";
            hash.rightStr = model.yhash;
            transTime.leftStr = @"交易时间";
            transTime.rightStr = [QuickMaker timeWithTimeInterval_allNumberStyleString:model.createdAt];
            confirm.leftStr = @"确认数";
            confirm.rightStr = TPString(@"%ld个确认",(long)model.confirm);
            transValue.leftStr = @"交易金额";
            transValue.rightStr = TPString(@"%.4f %@",model.value,model.tokenName);
            recepitAddr.leftStr = @"收款地址";
            recepitAddr.rightStr = model.to;
            transferAddr.leftStr = @"转账地址";
            transferAddr.rightStr = model.from;
            blockHeight.leftStr = @"区块高度";
            blockHeight.rightStr = @(model.height).stringValue;
            complete(@[hash,transTime,confirm,transValue,recepitAddr,transferAddr,blockHeight]);
        };
        GET_Block_Transaction_Tx_Hash.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Transaction_Tx_Hash.onEndConnection = ^{
            
        };
        
        [GET_Block_Transaction_Tx_Hash sendReuqestWithHash:self.yhash];
        
        
    };
}
- (void)setNav {
    
    self.customNavBar.title =@"交易信息";
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
