//
//  TPHeaderComView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCrowdConfig.h"
#import "TPCrowdfundingModel.h"
@interface TPHeaderComView : UIView

- (instancetype)initWithStyle:(TPCrowdfundStyle)crowdStyle;

@property (nonatomic, strong) TPCrowdfundingModel *croModel;

@property(nonatomic,copy)void (^participateBlock)(void);

@end
