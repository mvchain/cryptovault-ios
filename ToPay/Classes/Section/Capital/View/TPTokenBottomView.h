//
//  TPTokenBottomView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/19.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TPChainStyle)
{
    TPChainStyleUp,  // 上
    TPChainStyleDown,   // 下
};

@interface TPTokenBottomView : UIView

@property (nonatomic) UIButton * transferBtn;
@property (nonatomic) UIButton * receiptBtn;

- (instancetype)initWithStyle:(TPChainStyle)style;
/** 取出VP余额 */
@property (copy, nonatomic) void (^chainTakeBlock)(void);
/** 转账 */
@property (copy, nonatomic) void (^chainTransferBlock)(void);
/** 付款 */
@property (copy, nonatomic) void (^chainReceiptBlock)(void);

@property (nonatomic, strong) NSArray *titleArray;

@end
