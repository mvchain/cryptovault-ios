//
//  TPMVCBankSelectListView.h
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPMVCBankSelectListView : UIView
@property (strong,nonatomic) NSMutableArray *arrays ;
@property (strong,nonatomic) void(^tap)(NSInteger index);

- (void)refresh ;

@end

NS_ASSUME_NONNULL_END
