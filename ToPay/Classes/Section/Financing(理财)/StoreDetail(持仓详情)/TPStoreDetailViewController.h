//
//  TPStoreDetailViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"
#import "MyStoreItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPStoreDetailViewController : TPBaseViewController
@property (assign,nonatomic) NSInteger financial_id;
@property (strong,nonatomic) MyStoreItemModel *outModel; // 初始化时候外部传，
@end

NS_ASSUME_NONNULL_END
