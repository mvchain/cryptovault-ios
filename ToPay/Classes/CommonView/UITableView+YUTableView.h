//
//  UITableView+YUTableView.h
//  Forum
//
//  Created by yxyyxy on 02/04/2018.
//  Copyright © 2018 yxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "YUCellEntity.h"
#import "YUTableViewCell.h"
@class YUCellEntity;

@interface UITableView (YUTableView)

-(UITableViewCell *)cellByIndexPath:(NSIndexPath *)indexPath
                         dataArrays:(NSMutableArray *)dataArrays;

- (UITableViewCell *)cellByIndexPath:(NSIndexPath *)indexPath
                          dataArrays:(NSMutableArray *)dataArrays delegate:(id<YUCellDelegate>)delegate;

-(void)addHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block;

@end
