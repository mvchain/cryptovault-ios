//
//  TPEnableGoogleValidViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/4/9.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface TPEnableGoogleValidViewController : TPBaseViewController
@property (assign,nonatomic) NSInteger status ;
@property (copy,nonatomic) NSString *googleSecret;


@end

NS_ASSUME_NONNULL_END
