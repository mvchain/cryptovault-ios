//
//  TPMnemonicSettingViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"
@class TPMemonicStatusCollectionViewCellModel;
@protocol TPMnemonicSettingViewModelProtcol <NSObject>
- (void)checkoutMnemonicsWithEmail:(NSString *)email
                         mnemonics:(NSArray<NSString *> *)mnemonics
                          complete:(void(^)(BOOL isSucc,NSString *reasonInf))complete;
- (NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *)upDataArrays;
- (NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *)downDataArrays;

- (NSString *)emialAddr ;



@end

@interface TPMnemonicSettingViewController : TPBaseViewController
@property (strong, nonatomic) id<TPMnemonicSettingViewModelProtcol> viewModel;

@end

