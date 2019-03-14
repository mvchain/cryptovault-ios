//
//  TransactionRecordDetailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TransactionRecordDetailViewController.h"
#import "YUItemLeftRightCellEntity.h"
#import "YUPageListView.h"
#import "API_GET_Block_Address_Order_Id.h"
#import "TransactionRecordDetailInfo.h"
#import "YUItemLeftRightCellEntity.h"
@interface TransactionRecordDetailViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;
@end

@implementation TransactionRecordDetailViewController

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
        API_GET_Block_Address_Order_Id *GET_Block_Address_Order_Id = [[API_GET_Block_Address_Order_Id alloc] init];
        GET_Block_Address_Order_Id.onSuccess = ^(id responseData) {
            
            
            TransactionRecordDetailInfo *info  = [[TransactionRecordDetailInfo alloc] initWithDictionary:(NSDictionary *)responseData];
            if (info.classify == 0) {
                // 转账
                YUItemLeftRightCellEntity *fromEn = [[YUItemLeftRightCellEntity alloc] init];
                YUItemLeftRightCellEntity *toEn = [[YUItemLeftRightCellEntity alloc] init];
                YUItemLeftRightCellEntity *balanceEn = [[YUItemLeftRightCellEntity alloc] init];
                fromEn.leftStr = @"转账地址";
                fromEn.rightStr = info.from;
                toEn.leftStr = @"收款地址";
                toEn.rightStr = info.to;
                balanceEn.leftStr = @"转账金额";
                balanceEn.rightStr = TPString(@"%.4f %@",info.buyValue,info.buyTokenName);
                complete(@[fromEn,toEn,balanceEn]);
                
            }else {
                YUItemLeftRightCellEntity *fromEn = [[YUItemLeftRightCellEntity alloc] init];
                YUItemLeftRightCellEntity *buyEn = [[YUItemLeftRightCellEntity alloc] init];
                YUItemLeftRightCellEntity *toEn = [[YUItemLeftRightCellEntity alloc] init];
                YUItemLeftRightCellEntity *sellEn = [[YUItemLeftRightCellEntity alloc] init];
                fromEn.leftStr = @"买方";
                fromEn.rightStr  = info.from;
                buyEn.leftStr = @"买入金额";
                buyEn.rightStr = TPString(@"%.4f %@",info.buyValue,info.buyTokenName);
                toEn.leftStr = @"卖方";
                toEn.rightStr  = info.to;
                sellEn.leftStr = @"买入金额";
                sellEn.rightStr = TPString(@"%.4f %@",info.sellValue,info.sellTokenName);
                complete(@[fromEn,buyEn,toEn,sellEn]);
            }
            
        };
        GET_Block_Address_Order_Id.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Address_Order_Id.onEndConnection = ^{
            
        };
        [GET_Block_Address_Order_Id sendReuqestWithId:@(weakSelf.transactionId).stringValue];
        
        
    };
}
- (void)setNav {
    NSArray *titles = @[@"转账",@"币币交易"];
    self.customNavBar.title = titles[self.classify];
}


@end
