
/*!
 
 @header YUTableViewCell.h
 
 @abstract 所有Cell的基础类
 
 @author Created by Pan on 16/1/24.
 
 @version 1.2.0 16/1/24 Creation
 
 */
#import <UIKit/UIKit.h>

#import "YUCellDelegate.h"
@class YUCellEntity;


/*!
 
 @class YUTableViewCell
 
 @abstract 本类为所有自定义Cell的基类。
 
 */
@interface YUTableViewCell : UITableViewCell

/*!
 
 @property entity
 
 @abstract cell所对应的数据模型
 
 */
@property (strong,nonatomic) YUCellEntity * entity;

/*!
 
 @property yu_delegate
 
 @abstract cell所对应的代理对象，可以向代理发送如 “点赞按钮按下等事件”
 
 */
@property (weak,nonatomic) id<YUCellDelegate> yu_delegate ;

/**
 设置此cell的entity模型

 @param entity cell所对应的数据模型，方便在复用时更新相应的数据
 */
- (void)setEntity:(YUCellEntity *)entity;

@end
