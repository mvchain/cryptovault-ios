//
//  UITableView+YUTableView.m
//  Forum
//
//  Created by yxyyxy on 02/04/2018.
//  Copyright © 2018 yxy. All rights reserved.
//

#import "UITableView+YUTableView.h"


#import "UITableView+YUTableViewAddition.h"
@implementation UITableView (YUTableView)
- (void)noSeparatorLine {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (UITableViewCell *)cellByIndexPath:(NSIndexPath *)indexPath
                         dataArrays:(NSMutableArray *)dataArrays {
    
    YUCellEntity * entity = dataArrays[indexPath.row];
    entity.indexpath = indexPath;
    // 复用队列中取出。。
    YUTableViewCell * cell = [self dequeueReusableCellWithIdentifier:entity.cellId];
    if(cell ==nil){
        // 取出entity相对应的cell class
        Class cell_class =  [entity yu_relativeClass];
        NSString * cellId = NSStringFromClass(cell_class);
        [self registerCell:cell_class];
        cell = [self dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    }
    [cell setEntity:entity];
    return cell;
}

- (UITableViewCell *)cellByIndexPath:(NSIndexPath *)indexPath
                          dataArrays:(NSMutableArray *)dataArrays delegate:(id<YUCellDelegate>)delegate {
    
    YUTableViewCell * cell= (YUTableViewCell *)[self cellByIndexPath:indexPath dataArrays:dataArrays ];
    cell.yu_delegate=delegate;
    return cell;
}
- (void)addFooterWithBlock:(void(^)(MJRefreshFooter *footer))block {
    __weak typeof (self) wsf = self;
    MJRefreshAutoNormalFooter *normal = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        block(wsf.mj_footer);
        
    }];
    normal.stateLabel.hidden = YES;
    
    self.mj_footer = normal;
    
    
                      
}

- (void)addHeaderWithBlock:(void(^)(MJRefreshHeader *footer))block{
    
    __weak typeof (self) wsf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block(wsf.mj_header);
    }];

}
@end
