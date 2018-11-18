//
//  TPCrowdfundCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCrowdfundCell.h"

#import "TPHeaderComView.h"
#import "TPHeaderRecordView.h"

@interface TPCrowdfundCell ()

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) TPHeaderComView *comView;
@property (nonatomic, strong) TPHeaderRecordView *recView;

@property (nonatomic, strong) UIView  * sepV;

@property (nonatomic, strong) NSMutableArray<UILabel *> *nameArray;

@property (nonatomic, strong) NSMutableArray<UILabel *> *valueArray;

@property (nonatomic) TPCrowdfundStyle crowdStyle;

@end


@implementation TPCrowdfundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPCrowdfundStyle)crowdStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = TPF6Color;
        _crowdStyle = crowdStyle;
        _nameArray = [NSMutableArray array];
        _valueArray = [NSMutableArray array];
        
        _backView = [[UIView alloc] init];
        [_backView setLayer:5 WithBackColor:[UIColor whiteColor]];
        [self addSubview:_backView];
        
        if (_crowdStyle == TPCrowdfundStyleRecord)
        {
            _recView = [[TPHeaderRecordView alloc] init];
            [_backView addSubview:_recView];
        }
            else
        {
            _comView = [[TPHeaderComView alloc] initWithStyle:crowdStyle];
            [_backView addSubview:_comView];
        }
        
        _sepV = [[UIView alloc] init];
        _sepV.backgroundColor = TPF6Color;
        [_backView addSubview:_sepV];
        
        NSArray *names = @[@"众筹规模",@"每个用户限购",@"价格",@"每日释放比例",@"剩余时间"];
        NSArray *values = @[@"20.000.000 BTC",@"20.000.000 BTC",@"1BTC=10.000.000 VRT",@"0.01%",@"2天12小时60分"];
        
        for (NSUInteger i = 0; i < names.count; i ++)
        {
            UILabel *nameLab = [YFactoryUI YLableWithText:names[i] color:TP8EColor font:FONT(12)];
            [_backView addSubview:nameLab];
            
            [_nameArray addObject:nameLab];
            
            UILabel *valueLab = [YFactoryUI YLableWithText:values[i] color:TP8EColor font:FONT(12)];
            [_backView addSubview:valueLab];
            
            [_valueArray addObject:valueLab];
        }
    }
    return self;
}

-(void)participateClick
{
    NSLog(@"立即参与");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@10);
        make.top.equalTo(@12);
        make.right.equalTo(self).with.equalTo(@(-10));
        make.bottom.equalTo(self);
    }];
    
    if (_crowdStyle == TPCrowdfundStyleRecord)
    {
        [self.recView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.top.equalTo(@0);
             make.height.equalTo(@59);
             make.width.equalTo(self.backView.mas_width);
         }];
    }
        else
    {
        [self.comView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.top.equalTo(@0);
             make.height.equalTo(@89);
             make.width.equalTo(self.backView.mas_width);
         }];
    }
    
    [_sepV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo( self.crowdStyle == TPCrowdfundStyleRecord ?self.recView.mas_bottom:self.comView.mas_bottom);
        make.left.equalTo(@19);
        make.right.equalTo(self.backView).with.offset(-17);
        make.height.equalTo(@1);
    }];

    for (int i = 0; i < _nameArray.count; i++)
    {
        UILabel *nameLab = _nameArray[i];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@16);
            make.height.equalTo(@16);
            make.top.equalTo(self.sepV.mas_bottom).with.offset(11 + i * 20);
        }];

        UILabel *valueLab = _valueArray[i];

        [valueLab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.backView).with.offset(-16);
             make.height.equalTo(@16);
             make.top.equalTo(self.sepV.mas_bottom).with.offset(11 + i * 20);
         }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
