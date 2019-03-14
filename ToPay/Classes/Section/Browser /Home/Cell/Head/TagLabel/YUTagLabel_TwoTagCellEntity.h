//
//  YUTagLabel_TwoTagCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUCellEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUTagLabel_TwoTagCellEntity : YUCellEntity
@property (copy,nonatomic) NSString *leftStr ;
@property (copy,nonatomic) NSString *rightStr;
@property (assign,nonatomic)BOOL isLabelAlginCenter;

@end

NS_ASSUME_NONNULL_END
