//
//  TPInviteRegFirstPageTableViewCellEntity.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUCellEntity.h"



@interface TPInviteRegFirstPageTableViewCellEntity : YUCellEntity

yudef_property_copy(NSString, inviteCode);
yudef_property_copy(NSString, website);
yudef_property_strong(UIImage, qrimage);
yudef_property_assign(BOOL, qucikShotMode);

@end


