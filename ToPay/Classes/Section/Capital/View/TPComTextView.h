//
//  TPComTextView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPComTextView : UIView

@property (nonatomic, strong) UITextField *comTextField;

@property (nonatomic, strong) UILabel *comTitleLabel;

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc;

@end
