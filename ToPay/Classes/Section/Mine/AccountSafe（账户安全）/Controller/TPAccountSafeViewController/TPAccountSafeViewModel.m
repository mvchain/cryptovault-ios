//
//  TPAccountSafeViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPAccountSafeViewModel.h"

@implementation TPAccountSafeViewModel

#pragma mark lazy load
- (NSMutableArray <TPAccountSafeItemTableViewCellEntity *> *)dataArrays {
    if (!_dataArrays) {
         _dataArrays = [[NSMutableArray<TPAccountSafeItemTableViewCellEntity *> alloc] init];
        NSString *googleStr = @"关闭Google验证";
        if ( (TPLoginUtil.userInfo.googleCheck == 0)) {
            googleStr = @"开启Google验证";
        }
        NSArray *titles = @[@"修改邮箱",@"修改登录密码",@"修改支付密码",googleStr];
        for (NSString *title in titles ) {
            TPAccountSafeItemTableViewCellEntity *entity = [[TPAccountSafeItemTableViewCellEntity alloc] init];
            entity.title = title;
            [_dataArrays addObject:entity];
        }
    }
    return _dataArrays;
}

- (id)init {
    self = [super init];
    if (self) {
       
        
    }
    return self;
    
}
@end
