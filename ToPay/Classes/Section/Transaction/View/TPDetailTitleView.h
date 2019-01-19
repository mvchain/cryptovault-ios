//
//  TPDetailTitleView.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TPDetailTitleView : UIView

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *conLab;

- (instancetype)initWithTextAlignment:(NSTextAlignment)textAlignment;

@end
