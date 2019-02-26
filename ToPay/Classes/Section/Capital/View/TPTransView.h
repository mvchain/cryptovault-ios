//
//  TPTransView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/28.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPasswordView.h"
@class TPTransView;
@class TransTextView;

typedef NS_ENUM(NSInteger, TPTransStyle)
{
    TPTransStyleReservation,
    TPTransStyleTakeOut,
    TPTransStyleTransfer,
    TPTransStyleReleaseSell,
    TPTransStyleReleaseBuy,
};

@interface TPTransView : UIView

+(TPTransView *)createTransferViewStyle:(TPTransStyle)style;

-(void)showMenuWithAlpha:(BOOL)isShow;

/*
 * 标题
 */
@property (nonatomic, copy) NSString *title;
/*
 * 总计说明
 */
@property (nonatomic, copy) NSString *desc;
/*
 * 总计数
 */
@property (nonatomic, copy) NSString *Total;

@property (nonatomic, copy) NSString *con1;
@property (nonatomic, copy) NSString *con2;
@property (nonatomic, strong) UIViewController *pvc;

@property (nonatomic, strong) SYPasswordView * pasView;
@property (nonatomic, strong) NSMutableArray<TransTextView *> *arr_transViews;
@end


@interface TransTextView : UIView

@property (nonatomic, strong) UILabel *conLab;
@property (nonatomic, strong) UILabel *titleLabel;

-(instancetype)initWithTitle:(NSString *)title WithCon:(NSString *)con;
@end
