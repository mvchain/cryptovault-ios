//
//  TPMVCBanTableViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/4/3.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPPair.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPMVCBanTableViewController : UIViewController
@property (assign,nonatomic) NSInteger transactionType;

@property (strong,nonatomic) TPPair *curPair ;
- (void)refresh ;

@end

NS_ASSUME_NONNULL_END
