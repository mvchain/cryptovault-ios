//
//  TPAnnouncementView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/12.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPAnnouncementView.h"

@interface TPAnnouncementView()
@property (strong,nonatomic) UIImageView *imageView ;
@property (strong,nonatomic) UILabel *disPlayLabel ;
@property (strong,nonatomic) UILabel *hideLabel;
@property (strong,nonatomic) UILabel *label0;
@property (strong,nonatomic) UILabel *label1;
@property (strong,nonatomic) UIButton *button ;
@property (assign,nonatomic) NSInteger index ;
@property (strong,nonatomic) NSTimer *timer ;
@end
@implementation TPAnnouncementView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    self.index = 0;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 0, 14, 11)];
    [self.imageView setImage:[UIImage imageNamed:@"note"]];
    
    [self addSubview:self.imageView];
    self.label0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];

    self.disPlayLabel = self.label0;
    self.hideLabel = self.label1;
    NSArray<UILabel *> *labelsSetting = @[self.label0,self.label1];
    [labelsSetting bk_each:^(id obj) {
        UILabel *thisLabel = (UILabel *)obj;
        [self addSubview:thisLabel];
        [thisLabel setTextColor:[UIColor colorWithHex:@"#595971"]];
        [thisLabel setFont:[UIFont systemFontOfSize:13]];
        [thisLabel setFrame:CGRectMake(self.imageView.right+10, 0, 0, 14)];
    }];
    self.hideLabel.top = self.height;
    self.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.button];
    [self.button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    if (!titles)return ;
    [self.disPlayLabel setText:self.titles[0]];
    // 单条不滚动
    if(titles.count >1)
    [self startAnimate];
}
- (void)startAnimate {
    if (!self.titles) return ;
    if (_timer) [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(timeChange)
                                   userInfo:nil
                                    repeats:YES];
}
- (void)tap:(id)sender {
    self.tap((int)self.index);
    
}
- (void)timeChange {
    self.index = (self.index + 1) % self.titles.count;
    NSString *curTitle = self.titles[self.index];
    [self.hideLabel setText:curTitle];
    [self.hideLabel setTop:self.height];
    CGFloat centerY = self.height /2.0;
    [UIView animateWithDuration:0.36 animations:^{
        self.hideLabel.centerY = centerY;
        self.disPlayLabel.bottom = 0;
    } completion:^(BOOL finished) {
        UILabel *temp = self.hideLabel;
        self.hideLabel = self.disPlayLabel;
        self.disPlayLabel = temp;
    }];
}
- (void)layoutSubviews {
   
    [super layoutSubviews];
    [self yu_circleStyle];
    CGFloat selfWidth = self.width;
    CGFloat selfHeight = self.height;
    CGFloat centerY = selfHeight /2.0;
    self.imageView.centerY = centerY;
    
    NSArray<UILabel *> *labelsSetting = @[self.label0,self.label1];
    [labelsSetting bk_each:^(id obj) {
        UILabel *thisLabel = (UILabel *)obj;
        thisLabel.width = selfWidth - self.disPlayLabel.left - 20;
        thisLabel.centerY = centerY;
    }];
    self.button.frame = self.bounds;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
