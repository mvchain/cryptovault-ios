//
//  TPReleaseProjectDetailVC.h
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class  ReleaseProjectItem;

@interface TPReleaseProjectDetailVC : TPBaseViewController

@property (strong,nonatomic) ReleaseProjectItem *fromModel;

@property (assign,nonatomic) NSInteger projectId;

@property (copy,nonatomic) NSString *projectName;

@end

NS_ASSUME_NONNULL_END
