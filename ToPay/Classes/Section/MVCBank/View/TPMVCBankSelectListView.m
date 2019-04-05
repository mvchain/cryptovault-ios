//
//  TPMVCBankSelectListView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPMVCBankSelectListView.h"
#import "MVCBankSelectListCellEntity.h"
#import "YUPageListView.h"
@interface TPMVCBankSelectListView()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;


@end

@implementation TPMVCBankSelectListView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
    
}
- (void)setUp {
    yudef_weakSelf;
    self.pageListView.isUsingMJRefresh = NO;
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        complete(weakSelf.arrays);
    };
    self.pageListView.yu_didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        if (weakSelf.tap) {
            weakSelf.tap(indexPath.row);
        }
    };
}
- (void)refresh {
     [self.pageListView beginRefreshHeaderWithNoAnimate];
    
}

@end
