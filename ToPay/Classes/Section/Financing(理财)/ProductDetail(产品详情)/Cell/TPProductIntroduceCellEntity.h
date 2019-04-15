//
//  TPProductIntroduceCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUCellEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPProductIntroduceCellEntity : YUCellEntity
yudef_property_copy(NSString , title)
yudef_property_copy(NSString , content)
@end

NS_ASSUME_NONNULL_END
