//
//  TPInvitedRegisterViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInvitedRegisterViewModel.h"
#import "TPInviteRegFirstPageTableViewCellEntity.h"

@implementation TPInvitedRegisterViewModel
yudef_lazyLoad(NSMutableArray<YUCellEntity*>, dataArray, _dataArray)
- (id)init {
    self =[super init];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    TPInviteRegFirstPageTableViewCellEntity *entity = [[TPInviteRegFirstPageTableViewCellEntity alloc] init];
    entity.inviteCode = @"aabab";
    [self.dataArray addObject:entity];
}
@end
