//
//  TPMemonicStatusCollectionViewCell.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/15.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPMemonicStatusCollectionViewCellModel.h"
/**
 * 附带状态的cell 选择/不选中
 */

@interface TPMemonicStatusCollectionViewCell : UICollectionViewCell
- (void)setModel:(TPMemonicStatusCollectionViewCellModel *)model;
- (void)toBecircle;

@end


