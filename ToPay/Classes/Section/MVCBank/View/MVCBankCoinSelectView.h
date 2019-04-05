//
//  MVCBankCoinSelectView.h
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVCBankCoinSelectView : UIView
@property (strong,nonatomic) void (^tap)(id sender);
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
