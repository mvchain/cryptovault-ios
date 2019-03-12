//
//  YUItemLeftMidRightCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUCellEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUItemLeftMidRightCellEntity : YUCellEntity
@property (copy,nonatomic) NSString *leftStr ;
@property (copy,nonatomic) NSString *mideStr;
@property (copy,nonatomic) NSString *rightStr;
@end

NS_ASSUME_NONNULL_END
