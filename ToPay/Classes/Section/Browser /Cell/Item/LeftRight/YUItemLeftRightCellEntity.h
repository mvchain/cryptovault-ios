//
//  YUITemLeftRightCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YUItemLeftRightCellEntity : YUCellEntity
@property (copy,nonatomic) NSString *leftStr ;
@property (copy,nonatomic) NSString *rightStr;
@property (assign,nonatomic) BOOL isAlignCenterStyle;
@end

NS_ASSUME_NONNULL_END
