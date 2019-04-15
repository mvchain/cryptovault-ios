//
//  TPCapitalHeaderView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPAnnouncementView.h"
@interface TPCapitalHeaderView : UIView

@property (nonatomic, copy) NSString  *total;
@property (nonatomic, copy) NSString  *nickName;
@property (nonatomic) CGFloat  ratio;
@property (strong,nonatomic) UIButton *checkButton; //签到
@property (nullable, copy) void (^chooseCurrencyBlock)(void);
@property (nullable, copy) void (^checkTap)(void);
@property (strong,nonatomic) NSArray *announcements;

@property (strong,nonatomic) TPAnnouncementView *announcementView;


@end
