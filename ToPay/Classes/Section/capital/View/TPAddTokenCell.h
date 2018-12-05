//
//  TPAddTokenCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCurrencyList.h"
#import "TPAssetModel.h"
@interface TPAddTokenCell : UITableViewCell

@property (nonatomic, strong) CLData *clData;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withfilterData:(NSArray *)filters;

@property (nullable, copy) void (^operatingBlock)(BOOL isAdd,NSString *tokenId);

@end
