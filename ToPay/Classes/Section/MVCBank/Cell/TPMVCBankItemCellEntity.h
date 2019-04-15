//
//  TPMVCBankItemCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "YUCellEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPMVCBankItemCellEntity : YUCellEntity
@property (copy,nonatomic ) NSString *tokenName ;
@property (assign,nonatomic) NSInteger transType;

@end

NS_ASSUME_NONNULL_END
