//
//  ProgressView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/9.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "ProgressView.h"
@interface ProgressView()
@property (strong,nonatomic) UIView *foreView;
@end

@implementation ProgressView
- (UIView *)foreView {
    if (!_foreView) {
        _foreView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _foreView;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor colorWithHex:@"#E5E5E5"];
    self.foreView.backgroundColor =[UIColor colorWithHex:@"#9752FF"];
    [self yu_circleStyle];
    [self.foreView yu_circleStyle];
    [self addSubview:self.foreView];
    [self.foreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(@0);
        make.width.equalTo(@(self.width ));
        
    }];
    
}
- (void)setPersent:(CGFloat)persent  {
    [self updateConstraintsIfNeeded];
    [self.foreView mas_updateConstraints:^(MASConstraintMaker *make) {\
        CGFloat x = self.width * persent;
        
        make.width.equalTo(@(self.width * persent));
    }];
    [self setNeedsLayout];
}
@end
