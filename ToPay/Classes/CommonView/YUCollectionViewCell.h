//
//  YUCollectionViewCell.h
//  ScreamingCat
//
//  Created by 王志刚 on 2018/7/26.
//  Copyright © 2018年 王志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUCellDelegate.h"
@interface YUCollectionViewCell : UICollectionViewCell
@property (weak,nonatomic) id<YUCellDelegate> yu_delegate ;
@end
