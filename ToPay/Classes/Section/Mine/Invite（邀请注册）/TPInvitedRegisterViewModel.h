//
//  TPInvitedRegisterViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^bool_id_block)(BOOL isSucc,id data) ;

@interface TPInvitedRegisterViewModel : NSObject
yudef_property_strong(NSMutableArray<YUCellEntity*>, dataArray)
yudef_property_assign(int, curPage)

- (void)loadNewData:(bool_id_block)complete;
- (void)loadMoreData:(bool_id_block)complete ;

@end


