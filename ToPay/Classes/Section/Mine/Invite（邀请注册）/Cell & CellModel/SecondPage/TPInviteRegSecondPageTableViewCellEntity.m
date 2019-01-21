//
//  TPInviteRegSecondPageTableViewCellEntity.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/21.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInviteRegSecondPageTableViewCellEntity.h"

@implementation TPInviteRegSecondPageTableViewCellEntity
yudef_lazyLoad( NSMutableArray <TPInviteRegSecondPageItemTableViewCellEntity *>, dataArray, _dataArray)

- (void)initDataArray {
   self.dataArray =   [[NSMutableArray <TPInviteRegSecondPageItemTableViewCellEntity *> alloc] init];
}
@end
