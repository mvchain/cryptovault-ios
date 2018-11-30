
//  BCQMView.m
//  NIM
//
//  Created by FengKun on 2018/2/23.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BCQMView.h"

@interface BCQMView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray * imgArr;
@property (nonatomic, strong)UIView *backView;
@end

@implementation BCQMView

-(UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
//        _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        
        _backView.userInteractionEnabled = YES;
        
    }
    return _backView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollEnabled = NO;
        [self setLayer:4 WithBackColor:[UIColor blackColor]];
        self.alpha = 0.0f;

//        if ([state isEqualToString:@"state"])
//            [self setAnchorPoint:CGPointMake(frame.size.width / frame.size.width,0) forView:self];
//        else
            [self setAnchorPoint:CGPointMake((frame.size.width - 10) / frame.size.width,0) forView:self];//设置锚点，改变缩放点位置
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        
        
        self.titArr = @[@"添加好友",@"创建群",@"扫一扫",@"直播间"];
        self.imgArr = @[@"qm-btn-add",@"qm-btn-cgroup",@"qm-btn-scan",@"qm-btn-liveroom"];
    }
    return self;
}
#pragma mark -- UITapGestureRecognizer
-(void)dianji:(UITapGestureRecognizer *)sender
{
//    self.showMenuBlock(10);/
    [self showMenuWithAnimation:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([_stateStr isEqualToString:@"state"])
    return 36;
//    else
//    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"QMCell";
    
    QMCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    

    if (!cell)
        cell = [[QMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = TPMainColor;
    cell.textLabel.font = FONT(14);
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

-(void)setTitArr:(NSArray *)titArr
{
    _titArr = titArr;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.showMenuBlock(indexPath.row);
    [self showMenuWithAnimation:NO];
}

#pragma mark -- show with Animation
-(void)showMenuWithAnimation:(BOOL)isShow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window setUserInteractionEnabled:YES];
    [window addSubview:self.backView];
    [self.backView addSubview:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dianji:)];
    tap.delegate = self;
    [self.backView setUserInteractionEnabled:YES];
    [self.backView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.25 animations:^{
        if (isShow)
        {
            self.backView.hidden = NO;
            self.alpha = 1;
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
            else
        {
            
            self.alpha = 0;
            self.transform = CGAffineTransformMakeScale(0.01, 0.01);
            
        }
    } completion:^(BOOL finished) {

        if (isShow == NO) {
            self.backView.hidden = YES;
        }
    }];
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrgin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrgin.x - oldOrigin.x;
    transition.y = newOrgin.y - oldOrigin.y;
    
    view.center = CGPointMake(view.center.x - transition.x, view.center.y - transition.y);
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }
    //否则手势存在
    return YES;
}

@end

@implementation QMCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.iconImg = [YFactoryUI YImageViewWithimage:nil];
        [self addSubview:self.iconImg];
        
        self.titleLab = [YFactoryUI YLableWithText:@"" color:TPMainColor font:FONT(14)];
        [self addSubview:self.titleLab];
       
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(16);
         make.centerY.mas_equalTo(self.mas_centerY);
         make.size.mas_equalTo(CGSizeMake(18, 18));
     }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.iconImg.mas_right).with.offset(8);
         make.centerY.mas_equalTo(self.mas_centerY);
         make.height.mas_equalTo(14);
     }];
}

@end


