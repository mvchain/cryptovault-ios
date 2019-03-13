//
//  YUBlockListViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/13.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBlockListViewController.h"
#import "YUTagLabelCellEntity.h"
#import "YUItemLeftMidRightCellEntity.h"
#import "YUPageListView.h"
@interface YUBlockListViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;

@end
@implementation YUBlockListViewController

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
        YUTagLabelCellEntity *tag = [[YUTagLabelCellEntity alloc] init];
        tag.leftStr = @"区块高度";
        tag.midStr = @"交易数量";
        tag.rightStr = @"出块时间";
        YUItemLeftMidRightCellEntity *item = [[YUItemLeftMidRightCellEntity alloc]init];
        item.leftStr = @"7545";
        item.mideStr =  @"156";
        item.rightStr = [QuickMaker timeWithTimeInterval_allNumberStyleString:0];
        complete(@[tag,item]);
    };
    
}
- (void)setNav {
    self.customNavBar.title = @"区块列表";
    
}


@end
