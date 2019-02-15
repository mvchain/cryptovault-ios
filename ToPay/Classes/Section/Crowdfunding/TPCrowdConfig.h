//
//  TPCrowdConfig.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/14.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#ifndef TPCrowdConfig_h
#define TPCrowdConfig_h

typedef NS_ENUM(NSUInteger, TPCrowdfundStyle)
{
    TPCrowdfundStyleReservation,  // 预约中
    TPCrowdfundStyleComingSoon,   // 即将预约
    TPCrowdfundStyleEnd,          // 已结束
    TPCrowdfundStyleIJoined,//我参与的
    TPCrowdfundStyleRecord       // 记录

};

#endif /* TPCrowdConfig_h */
