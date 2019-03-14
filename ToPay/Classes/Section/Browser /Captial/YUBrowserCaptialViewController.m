//
//  YUBrowserCaptialViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBrowserCaptialViewController.h"
#import "YUPageListView.h"
#import "API_GET_Block_Address_Balance.h"
#import "BlockBrowserCaptialItem.h"
#import "YUTagLabel_TwoTagCellEntity.h"
#import "YUItemLeftRightCellEntity.h"
@interface YUBrowserCaptialViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;
@end

@implementation YUBrowserCaptialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.atly_top.constant = self.customNavBar.height + 5;
    [self configListView];
    [self.pageListView beginRefreshHeader];
    // Do any additional setup after loading the view from its nib.
}

- (void)configListView  {
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        API_GET_Block_Address_Balance *GET_Block_Address_Balance =[[API_GET_Block_Address_Balance alloc] init];
        GET_Block_Address_Balance.onSuccess = ^(id responseData) {
            NSArray *datas = (NSArray *)responseData;
            NSMutableArray *listDatas = [[NSMutableArray alloc] init];
            YUTagLabel_TwoTagCellEntity *tag = [[YUTagLabel_TwoTagCellEntity alloc]init];
            tag.leftStr = @"币种";
            tag.rightStr = @"余额";
            [listDatas addObject:tag];
            for (NSDictionary *dict in datas) {
                BlockBrowserCaptialItem *item = [[BlockBrowserCaptialItem alloc] initWithDictionary:dict];
                YUItemLeftRightCellEntity *en = [[YUItemLeftRightCellEntity alloc]init];
                en.data = item;
                en.leftStr = item.tokenName;
                en.rightStr = TPString(@"%.4f",item.value);
                [listDatas addObject:en];
            }
            complete(listDatas);
        };
        GET_Block_Address_Balance.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Address_Balance.onEndConnection = ^{
            
        };
        [GET_Block_Address_Balance sendReuqestWithPublicKey:self.publicKey];
        
    };
}
- (void)setNav {
    self.customNavBar.title = @"区块列表";
}
@end
