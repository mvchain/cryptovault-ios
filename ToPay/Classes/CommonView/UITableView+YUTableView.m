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

- (UITableViewCell *)cellByIndexPath:(NSIndexPath *)indexPath
                         dataArrays:(NSMutableArray *)dataArrays {
    
    YUCellEntity * entity = dataArrays[indexPath.row];
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

-(void)addHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block{
    
    
    NSMutableArray * mutabArr = [[NSMutableArray alloc]init];
    
    for(int i = 1 ;i <= 10; i++ ){
        //loader2_06
        NSString * str = [NSString stringWithFormat:@"load2_%02d",i];
        NSLog(@"%@",str);
        
        [mutabArr addObject:  [UIImage imageNamed:str]];
        
    }
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *header;

//    header = [MJdogGrey headerWithRefreshingBlock:block];
    
    //-------以上是使用block方法【不包含animationRefresh方法】,动画设置在上面的部分代码---------
    header = [MJRefreshGifHeader headerWithRefreshingBlock:block];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //1.设置普通状态的动画图片
    [header setImages:mutabArr duration:0.7 forState:MJRefreshStateIdle];
    //2.设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:mutabArr duration:0.7 forState:MJRefreshStatePulling];
    //3.设置正在刷新状态的动画图片
    [header setImages:mutabArr duration:0.7 forState:MJRefreshStateRefreshing];
    
    self.mj_header = header;

    
 
}
@end
