//
//  TPMnemonicDisplayViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMnemonicDisplayViewController.h"
#import "TPMnemonicDisplayViewModel.h"
#import "TPMemonicCollectionViewCell.h"
#import "TPMnemonicSettingViewController.h"
#import "TPMnemonicSettingViewModel.h"
#define CELL_COLLECT_ID @"CELL_COLLECT_ID"
#define HEIGHT_CELL 30
@interface TPMnemonicDisplayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) TPMnemonicDisplayViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *privateKeyLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alyt_collect_height;


@end

@implementation TPMnemonicDisplayViewController

#pragma mark lazy load
- (TPMnemonicDisplayViewModel *)viewModel {
    if( !_viewModel ) {
        _viewModel = [[TPMnemonicDisplayViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark initialize
- (void)initUI {
    NSString *privateKey = self.viewModel.cacheRegisterResponseModel.privateKey;
    [self.privateKeyLabel setText:privateKey];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TPMemonicCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_COLLECT_ID];
    _alyt_collect_height.constant = (self.viewModel.cacheRegisterResponseModel.mnemonics.count / 3) * HEIGHT_CELL ;
    [self.nextStepButton gradualChangeStyle];
    [self.collectionView yu_smallCircleStyle];
}
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.cacheRegisterResponseModel.mnemonics.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPMemonicCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CELL_COLLECT_ID forIndexPath:indexPath];
    NSString *title = self.viewModel.cacheRegisterResponseModel.mnemonics[indexPath.row];
    [cell setTitle:title];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat ew =  collectionView.width / 3.0;
    return CGSizeMake(ew, HEIGHT_CELL);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake ( 0 , 0 , 0 , 0 );
}

#pragma mark event method

- (IBAction)onNextStepTap:(id)sender {
    TPMnemonicSettingViewController *mnemonicSetting = [[TPMnemonicSettingViewController alloc] init];
    TPMnemonicSettingViewModel *model = [[TPMnemonicSettingViewModel alloc] init];
    mnemonicSetting.viewModel = model;
    [self.navigationController pushViewController:mnemonicSetting animated:YES];
    
}
@end
