//
//  YUErrorCellEntity.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/2.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "YUErrorCellEntity.h"

@implementation YUErrorCellEntity
- (id)init {
    self = [super init];
    if (self) {
        self.yu_cellHeight = 60.0;
        
    }
    return self;
}

+ (YUErrorCellEntity *)quickInit:(NSString *)info {
    YUErrorCellEntity *en =  [[YUErrorCellEntity alloc] init];
    en.data = info;
    return en;
    
}
@end
