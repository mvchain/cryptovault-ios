//
//  YUBrowserHeadCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUCellEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUBrowserHeadCellEntity : YUCellEntity
@property (assign,nonatomic) NSInteger blockHeight ;
@property (assign,nonatomic) NSInteger transnum ;
@property (assign,nonatomic) NSInteger confirmSecond ;
@end

NS_ASSUME_NONNULL_END
