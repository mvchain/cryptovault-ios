//
//  BCQMView.h
//  NIM
//
//  Created by FengKun on 2018/2/23.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMCell;
@interface BCQMView : UITableView <UITableViewDelegate,UITableViewDataSource>

-(void)showMenuWithAnimation:(BOOL)isShow;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@property (nonatomic, copy) void (^showMenuBlock)(NSInteger currentIndex);
@property (nonatomic, strong) NSString *stateStr;
@property (nonatomic, strong) NSArray * titArr;
@end

@interface QMCell : UITableViewCell

/** image */
@property (nonatomic, strong) UIImageView *iconImg;

/** title */
@property (nonatomic, strong) UILabel *titleLab;



@end
