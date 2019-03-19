//
//  YUErrorCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/2.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "YUCellEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUNoDataCellEntity : YUCellEntity
+ (YUErrorCellEntity *)quickInit:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
