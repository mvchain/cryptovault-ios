/*!
 
 @header YUCellEntity.h
 
 @abstract 所有cellEntity的基类
 
 @author Created by Pan on 16/1/24.
 
 @version 1.2.0 16/1/24 Creation
 
 */

#import <UIKit/UIKit.h>

/*!
 
 @class YUCellEntity
 
 @abstract 本类为所有自定义CellEntity的基类。
 
 */
@interface YUCellEntity : NSObject
/*!
 
 @property cellId
 
 @abstract 复用id，在创建本对象时就应该确定
 
 */
@property (copy,nonatomic) NSString * cellId;

/*!
 
 @property yu_cellHeight
 
 @abstract 计算并缓存本cell的高度
 
 */
@property (assign,nonatomic) CGFloat yu_cellHeight;

/*!
 
 @property yu_relativeClass
 
 @abstract 本数据模型所对应的cell类
 
 */
@property (weak,nonatomic) Class yu_relativeClass ;
@property (strong,nonatomic) NSIndexPath *indexpath ;

@property (strong,nonatomic) id data ;

@property (strong,nonatomic) void(^callBackByCell)(NSDictionary *info);
@property (strong,nonatomic) void(^callBackByOuter)(NSDictionary *info); // 外部回调

- (void) fillDataByNSDictionary:(NSDictionary *) dict ;

@end
