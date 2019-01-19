//
//  TPInvitedRegisterViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPInvitedRegisterViewModel : NSObject
yudef_property_strong(NSMutableArray<YUCellEntity*>, dataArray)
- (void)getInvitedCodeWithCallBack:(void(^)(BOOL isSucc,NSString *info))complete;

@end


