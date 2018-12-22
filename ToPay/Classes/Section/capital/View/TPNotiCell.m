//
//  TPNotiCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPNotiCell.h"

@interface TPNotiCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *pageV;

@property (nonatomic, strong) UILabel *clickLab;

@property (nonatomic, strong) UILabel *timeLab;

@end

@implementation TPNotiCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _backView = [[UIView alloc] init];
        [_backView setLayer:5 WithBackColor:[UIColor whiteColor]];
        [self addSubview:_backView];
        
        _pageV = [[UIView alloc] init];

        [_pageV setLayer:2 WithBackColor:[UIColor redColor]];
        [_backView addSubview:_pageV];
        
        _clickLab = [YFactoryUI YLableWithText:@"成功参与iconic：4600 BTC" color:TP59Color font:FONT(15)];
        [_backView addSubview:_clickLab];
        
        _timeLab = [YFactoryUI YLableWithText:@"2018-10-23 12:24" color:[UIColor colorWithHex:@"#A7A9B8"] font:FONT(12)];
        [_backView addSubview:_timeLab];
    }
    return self;
}

-(void)setNotiModel:(TPNotificationModel *)notiModel
{
    _notiModel = notiModel;
    
   
    _pageV.hidden = YES;
    
    
    _timeLab.text = [notiModel.createdAt conversionTimeStamp];
    
    _clickLab.text = notiModel.message;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(self);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@64);
    }];
    
    [self.pageV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.equalTo(self.backView).with.offset(16);
         make.size.equalTo(@4);
     }];
    
    [self.clickLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.pageV.mas_right).with.offset(4);
         make.top.equalTo(@8);
         make.height.equalTo(@20);
     }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.backView.mas_right).with.offset(-16);
         make.bottom.equalTo(self.backView).with.offset(-6);
         make.height.equalTo(@22);
     }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
