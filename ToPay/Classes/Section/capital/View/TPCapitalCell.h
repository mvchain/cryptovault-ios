//
//  TPCapitalCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPAssetModel.h"
@interface TPCapitalCell : UITableViewCell

@property (nonatomic, strong) TPAssetModel *assetModel;

@property (nonatomic) CGFloat  ratio;
@end
