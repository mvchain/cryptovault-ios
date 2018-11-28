//
//  TPLoginViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/27.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPStartViewController.h"
@class TPLoginTextView;
@interface TPLoginViewController : TPStartViewController

@end




@interface TPLoginTextView : UIView

@property (nonatomic, strong) UITextField *comTextField;

@property (nonatomic, strong) UILabel *comTitleLabel;

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc;

@end





