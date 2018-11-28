//
//  TPCrowdfundCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCrowdConfig.h"
#import "TPHeaderComView.h"

@interface TPCrowdfundCell : UITableViewCell
@property (nonatomic, strong) TPHeaderComView *comView;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPCrowdfundStyle)crowdStyle;

@end
