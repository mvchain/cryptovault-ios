//
//  TPMnemonicSettingViewModel_ResetPassWd.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TPMemonicStatusCollectionViewCellModel.h"
#import "TPRegisterInfoModel.h"
#import "TPMnemonicSettingViewController.h"
@interface TPMnemonicSettingViewModel_ResetPassWd : NSObject <TPMnemonicSettingViewModelProtcol>
@property (strong, nonatomic) NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *upDataArrays;
@property (strong, nonatomic) NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *downDataArrays;
@property (copy,nonatomic) NSString *emialAddr;
- (void)setDownDataArraysByArr:(NSArray *)arr ;
@end


