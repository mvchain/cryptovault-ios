//
//  TPMnemonicSettingViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/15.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPRegisterResponseModel.h"
#import "TPMemonicStatusCollectionViewCellModel.h"
#import "TPRegisterInfoModel.h"
@interface TPMnemonicSettingViewModel : NSObject
@property (strong, nonatomic) NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *upDataArrays;
@property (strong, nonatomic) NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *downDataArrays;

#pragma mark http service
- (void)checkoutMnemonicsWithEmail:(NSString *)email
                mnemonics:(NSArray<NSString *> *)mnemonics
                 complete:(void(^)(BOOL isSucc,NSString *reasonInf))complete;

#pragma mark local service

- (TPRegisterInfoModel *)cacheRegisterModel;

- (TPRegisterResponseModel *)cacheRegisterResponseModel;

@end


