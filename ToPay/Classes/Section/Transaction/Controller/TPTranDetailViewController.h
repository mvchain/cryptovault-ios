//
//  TPTranDetailViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPStartViewController.h"
#import "TPVRTModel.h"
@interface TPTranDetailViewController : TPStartViewController

@property (nonatomic, strong) TPVRTModel *vrtTopic;
@property (nonatomic, copy) NSString  *currName;

@end