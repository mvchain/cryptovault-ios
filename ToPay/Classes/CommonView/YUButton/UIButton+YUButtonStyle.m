//
//  UIButton+YUButtonStyle.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "UIButton+YUButtonStyle.h"
#import "UIView+YUStyle.h"
#import "UIButton+Gradient.h"
@implementation UIButton (YUButtonStyle)

- (void)gradualChangeStyle {
    [self yu_circleStyle];
    [self gradientButtonWithSize:self.bounds.size colorArray:@[[UIColor colorWithHex:@"#007AFF"],[UIColor colorWithHex:@"#5856D6"]] percentageArray:@[@0,@1] gradientType:GradientFromLeftToRight];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)allWhiteStyle {
    [self yu_circleStyle];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setTitleColor:[UIColor colorWithHex:@"#595971"] forState:UIControlStateNormal];
}

- (void)whiteBorderStyle {
    
    [self yu_circleStyle];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
}
- (void)rectBlackBorderStyle {
    [self yu_smallCircleStyle];
    [self yu_boarderStyle:[UIColor colorWithHex:@"#595971"]];
    self.layer.borderWidth = 1;
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTitleColor:[UIColor colorWithHex:@"#595971"] forState:UIControlStateNormal];
    
}
- (void)rectGrayBorderStyle; {
    [self yu_smallCircleStyle];
    [self yu_boarderStyle:[UIColor colorWithHex:@"#F2F2F2"]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.borderWidth = 1;
    [self setTitleColor:[UIColor colorWithHex:@"#C7C7D1"] forState:UIControlStateNormal];
}

- (void)clarityStyle {
    [self yu_circleStyle];
    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
}
@end
