//
//  TPMnemonicSettingViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMnemonicSettingViewController.h"
#import "TPMnemonicSettingViewModel.h"
#import "TPMemonicStatusCollectionViewCell.h"
#import "TPMemonicCollectionViewCell.h"
#import "YUTabBarController.h"
#import "TPMnemonicSettingViewModel_ResetPassWd.h"
#import "TPRestPasswordViewModel.h"
#import "TPResetPwdOneTextFiledViewController.h"
#define UP_CELL_COLLECT_ID @"UP_CELL_COLLECT_ID"
#define DOWN_CELL_COLLECT_ID @"DOWN_CELL_COLLECT_ID"

#define DOWN_CELL_HEIGHT 30
#define UP_CELL_HEIGHT 20
#define Line_Space 16
#define V_Space 15
// 代理是在xib上拖拽的
@interface TPMnemonicSettingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *upCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *downCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_downCollection_height;
@property (weak, nonatomic) IBOutlet UIButton *nextSetpButton;

@end

@implementation TPMnemonicSettingViewController

#pragma mark lazy load

#pragma mark initialize
- (void)initUI {
    NSAssert(self.viewModel,@"不能为空");
    [self.upCollectionView registerNib:[UINib nibWithNibName:@"TPMemonicCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:UP_CELL_COLLECT_ID];
    [self.downCollectionView registerNib:[UINib nibWithNibName:@"TPMemonicStatusCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DOWN_CELL_COLLECT_ID];
    NSInteger nums = self.viewModel.downDataArrays.count;
    NSInteger row_count = ( nums / 3 );
    CGFloat h = row_count * DOWN_CELL_HEIGHT + Line_Space* (row_count-1);
    self.atly_downCollection_height.constant = h;
    [self.upCollectionView yu_smallCircleStyle];
    [self.downCollectionView yu_smallCircleStyle];
    [self.nextSetpButton gradualChangeStyle];
}

#pragma mark system method 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ( collectionView == self.upCollectionView ) {
        return self.viewModel.upDataArrays.count;
    }else {
        return self.viewModel.downDataArrays.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    if (collectionView == self.upCollectionView) {
        return [self returnUpCollectionViewCell:indexPath];
    }else {
        return [self returnDownCollectionViewCell:indexPath];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.upCollectionView) {
        CGFloat ew =  collectionView.width / 3.0;
        return CGSizeMake(ew, 20);
    } else {
        CGFloat ew =  (collectionView.width - V_Space*2) /3 ;
        return CGSizeMake(ew, DOWN_CELL_HEIGHT);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Line_Space; // 行间距
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.upCollectionView) {
        return 0;
    }else {
        return V_Space;
    }
}
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    if (collectionView == self.upCollectionView) {
        return UIEdgeInsetsMake ( 13 , 0 , 0 , 0 ); // 顶部填充13
    }
    return UIEdgeInsetsMake ( 0 , 0 , 0 , 0 );
}

#pragma mark local method
- (UICollectionViewCell *)returnUpCollectionViewCell:(NSIndexPath *)indexPath {
    TPMemonicCollectionViewCell *cell = [self.upCollectionView dequeueReusableCellWithReuseIdentifier:UP_CELL_COLLECT_ID forIndexPath:indexPath];
    NSString *title = self.viewModel.upDataArrays[indexPath.row].title;
    [cell setTitle:title];
    return cell;
}
- (UICollectionViewCell *)returnDownCollectionViewCell:(NSIndexPath *)indexPath {
    TPMemonicStatusCollectionViewCell *cell = [self.downCollectionView dequeueReusableCellWithReuseIdentifier:DOWN_CELL_COLLECT_ID forIndexPath:indexPath];
    TPMemonicStatusCollectionViewCellModel *model = self.viewModel.downDataArrays[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma mark event method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.upCollectionView) {
        TPMemonicStatusCollectionViewCellModel *model = self.viewModel.upDataArrays[indexPath.row];
        model.isSelected = !model.isSelected;
        [self.viewModel.upDataArrays removeObject:model];
        
    }
    if( collectionView == self.downCollectionView ) {
        TPMemonicStatusCollectionViewCellModel *model = self.viewModel.downDataArrays[indexPath.row];
        if (!model.isSelected) {
            // 当前没选中，按下
                [self.viewModel.upDataArrays addObject:model];
          
        }else {
            // 当前选中状态,取消
                [self.viewModel.upDataArrays removeObject:model];
        }
        model.isSelected = !model.isSelected;
    }
    [self.upCollectionView reloadData];
    [self.downCollectionView reloadData];
}
- (IBAction)onNextStepTap:(id)sender {
    NSMutableArray *marr = [[NSMutableArray alloc]init];
    if (self.viewModel.upDataArrays.count != self.viewModel.downDataArrays.count) {
        [self showErrorText:@"请选完整"];
        return;
    }
    for (TPMemonicStatusCollectionViewCellModel *model in self.viewModel.upDataArrays) {
        [marr addObject:model.title];
    }
    [self.viewModel checkoutMnemonicsWithEmail:self.viewModel.emialAddr
                                     mnemonics:marr
                                      complete:^(BOOL isSucc, NSString *info) {
                                          if (isSucc) {
                                              if( [self.viewModel isKindOfClass:TPMnemonicSettingViewModel.class] ) {
                                                  // 注册时
                                                  [self showSuccessText:@"激活成功"];
                                                 YYCache *cache = [YYCache cacheWithName:kModelCache];
                                                  [cache removeObjectForKey:kReginfoModelCacheKey];
                                                  [cache removeObjectForKey:kRegResponseCacheKey];
                                                  UIApplication *app = [UIApplication sharedApplication];
                                                  AppDelegate *dele = (AppDelegate*)app.delegate;
                                                  dele.window.rootViewController = [[YUTabBarController alloc] config];
                                              }else if([self.viewModel isKindOfClass:TPMnemonicSettingViewModel_ResetPassWd.class]) {
                                                  TPResetPwdOneTextFiledViewController *reset = [[TPResetPwdOneTextFiledViewController alloc] init];
                                                  TPRestPasswordViewModel *model = [[TPRestPasswordViewModel alloc] init];
                                                  model.onceToken = info;
                                                  reset.viewModel =model;
                                                  [self.navigationController pushViewController:reset animated:YES];
                                                  
                                              }
                                          }else {
                                              [self showErrorText:info];
                                          }
    }];
}
@end
