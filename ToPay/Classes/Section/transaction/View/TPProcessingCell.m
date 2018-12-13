//
//  TPProcessingCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/23.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPProcessingCell.h"

@interface TPProcessingCell ()
@property (nonatomic, strong) UIView  * backView;
@property (nonatomic, strong) UILabel  * nickLab;
@property (nonatomic, strong) UIButton * tranBtn;
@property (nonatomic, strong) UIView   * sepView;
@property (nonatomic, strong) NSMutableArray<UILabel *>  * titleArray;
@property (nonatomic, strong) NSMutableArray<UILabel *>  * conArray;
@property (nonatomic, strong) UILabel  * timeLab;
@property (nonatomic)  TPStatusStyle statusStyle;
@property (nonatomic)  BOOL isProcessing;
@end

@implementation TPProcessingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPStatusStyle)statusStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        _statusStyle = statusStyle;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleArray = [NSMutableArray<UILabel *> array];
        _conArray = [NSMutableArray<UILabel *> array];
        
        self.backgroundColor = TPF6Color;
        
        _backView = [[UIView alloc] init];
        [_backView setLayer:15 WithBackColor:[UIColor whiteColor]];
        [self addSubview:_backView];
        
        _nickLab = [YFactoryUI YLableWithText:@"购买USDT/VRT" color:TP59Color font:FONT(16)];
        [_backView addSubview:_nickLab];
        
        self.isProcessing = _statusStyle == TPStatusStyleProcessing;
        
        _tranBtn = [YFactoryUI YButtonWithTitle:self.isProcessing ? @"撤单" : @"已成交" Titcolor:self.isProcessing ? [UIColor whiteColor]:TPD5Color font:FONT(13) Image:nil target:self action:@selector(transClick)];
        [_tranBtn setLayer:18 WithBackColor:self.isProcessing ? TPMainColor:[UIColor colorWithHex:@"#ECEEF1"]];
        [_backView addSubview:_tranBtn];
        
        _sepView = [[UIView alloc] init];
        _sepView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
        [_backView addSubview:_sepView];
        
        NSArray *titArr = self.isProcessing ? @[@"待购买数量",@"价格"]:@[@"单号",@"卖家",@"购买量",@"价格"];
        NSArray *conArr = self.isProcessing ? @[@"20.000.000 BTC",@"1234567.1234 VRT"]:@[@"123456789",@"LCF666",@"1234567.1234 VRT",@"1234567.1234 VRT"];
        
        for (int i = 0 ; i < titArr.count; i++)
        {
            UILabel *titleLab = [YFactoryUI YLableWithText:titArr[i] color:TP59Color font:FONT(12)];
            [_backView addSubview:titleLab];
            [self.titleArray addObject:titleLab];
            
            
            UILabel *conLab = [YFactoryUI YLableWithText:conArr[i] color:TP59Color font:FONT(12)];
            [_backView addSubview:conLab];
            [self.conArray addObject:conLab];
        }
        
        _timeLab = [YFactoryUI YLableWithText:@"2018-11-21 10:32" color:[UIColor colorWithHex:@"#A7A9B8"] font:FONT(11)];
        [_backView addSubview:_timeLab];
    }
    return self;
}

-(void)setRecord:(TPRecordModel *)record
{
    _record = record;
    
    if (self.isProcessing == YES)
    {
        self.conArray[0].text = record.deal;
        self.conArray[1].text = record.price;
    }
        else
    {
        self.conArray[0].text = record.orderNumber;
        self.conArray[1].text = record.nickname;
        self.conArray[2].text = record.deal;
        self.conArray[3].text = record.price;
    }
    
    
    _timeLab.text = [record.createdAt conversionTimeStamp];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@10);
        make.top.equalTo(@12);
        make.width.equalTo(self.mas_width).with.offset(-20);
        make.height.equalTo(self.isProcessing ? @156: @188);
    }];
    
    [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@16);
        make.top.equalTo(@20);
        make.height.equalTo(@21);
    }];
    
    [self.tranBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(self.backView.mas_right).with.offset(-16);
        make.top.equalTo(@12);
        make.height.equalTo(@36);
        make.width.equalTo(@88);
    }];
    
    [self.sepView  mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@19);
        make.right.equalTo(@(-17));
        make.height.equalTo(@1);
        make.top.equalTo(self.nickLab.mas_bottom).with.offset(20);
    }];
    
    UILabel *titleLab;
    for (int i = 0 ; i < self.titleArray.count; i++)
    {
        titleLab = self.titleArray[i];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@16);
            make.top.equalTo(self.sepView.mas_bottom).with.offset(12 + i * 20);
            make.height.equalTo(@16);
        }];
        
        UILabel *conLab = self.conArray[i];
        [conLab mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(@(-16));
             make.top.equalTo(self.sepView.mas_bottom).with.offset(12 + i * 20);
             make.height.equalTo(@16);
         }];
    }
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(self.nickLab);
        make.top.equalTo(titleLab.mas_bottom).with.offset(12);
        make.height.equalTo(@15);
    }];
}

-(void)transClick
{
    NSLog(@"已成交");
    if (self.withdrawalBlock)
    {
        self.withdrawalBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
