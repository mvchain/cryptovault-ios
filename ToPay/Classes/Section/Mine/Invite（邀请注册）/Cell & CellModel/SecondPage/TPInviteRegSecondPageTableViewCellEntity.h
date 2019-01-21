//
//  TPInviteRegSecondPageTableViewCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/21.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTableViewCell.h"
@class TPInviteRegSecondPageItemTableViewCellEntity;
@interface TPInviteRegSecondPageTableViewCellEntity : YUCellEntity
@property (strong,nonatomic) NSMutableArray <TPInviteRegSecondPageItemTableViewCellEntity *> *dataArray;
- (void)initDataArray;

@end


