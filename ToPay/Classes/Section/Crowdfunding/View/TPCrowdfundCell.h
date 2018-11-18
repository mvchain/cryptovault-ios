//
//  TPCrowdfundCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCrowdConfig.h"
//typedef NS_ENUM(NSUInteger, TPCrowdfundStyle)
//{
//    TPCrowdfundStyleReservation,  // 预约
//    TPCrowdfundStyleComingSoon,   // 即将预约
//    TPCrowdfundStyleEnd,          // 已结束
//    TPCrowdfundStyleRecord,       // 记录
//};

@interface TPCrowdfundCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPCrowdfundStyle)crowdStyle;

@end
