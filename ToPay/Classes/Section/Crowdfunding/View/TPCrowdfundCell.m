//
//  TPCrowdfundCell.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCrowdfundCell.h"
#import "TPHeaderRecordView.h"


@interface TPCrowdfundCell ()

@property (nonatomic, strong) UIView * backView;


@property (nonatomic, strong) TPHeaderRecordView *recView;

@property (nonatomic, strong) UIView  * sepV;

//@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) NSMutableArray<UILabel *> *nameArray;

@property (nonatomic, strong) NSMutableArray<UILabel *> *valueArray;

@property (nonatomic) TPCrowdfundStyle crowdStyle;
@property (nonatomic ,strong) CountDown *countD;
@end


@implementation TPCrowdfundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPCrowdfundStyle)crowdStyle countD:(CountDown *)countD
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = TPF6Color;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _countD = countD;
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
        
//        self.timeLab = [YFactoryUI YLableWithText:@"dasda" color:[UIColor redColor] font:FONT(15)];
//        [_backView addSubview:self.timeLab];
        
        NSArray *names;
        
        if (_crowdStyle != TPCrowdfundStyleRecord)
        {
            names = @[@"众筹规模",@"每个用户限购",@"价格",@"每日释放比例",@"剩余时间"];
        }
            else
        {
            names = @[@"订单号",@"兑换比例",@"每日释放比例",@"支付金额/预约金额",@"成功数量/预约数量",@"预约结束时间"];
        }
        NSArray *values = @[@"20.000.000 BTC",@"20.000.000 BTC",@"1BTC=10.000.000 VRT",@"0.01%",@"2天12小时60分",@""];
        
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

-(void)setCroModel:(TPCrowdfundingModel *)croModel
{
    _croModel = croModel;
    
    if (_crowdStyle != TPCrowdfundStyleRecord)
    {
        _comView.croModel = _croModel;
        _valueArray[0].text = TPString(@"%@ %@",_croModel.total,_croModel.tokenName) ;
        _valueArray[1].text = TPString(@"%@ %@",_croModel.projectLimit,_croModel.tokenName);
        _valueArray[2].text = TPString(@"1 %@ = %@ %@",croModel.tokenName,croModel.ratio,croModel.baseTokenName);
        _valueArray[3].text = TPString(@"%@%%",_croModel.releaseValue);
        
//        self.timeLab.text = @"dsadasdas";
        

        long long startLongLong = 1467713971000;
        long long finishLongLong = 1467714322000;

        [self.countD countDownWithStratTimeStamp:startLongLong finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second)
        {
//            NSLog(@"%ld天%ld小时%ld分",(long)day,(long)hour,(long)minute);
//            self.timeLab.text = TPString(@"%ld天%ld小时%ld分",(long)day,(long)hour,(long)minute);
        }];
    }
}

-(void)setCroRecordModel:(TPCroRecordModel *)croRecordModel
{
    _croRecordModel = croRecordModel;
    
    if (_crowdStyle == TPCrowdfundStyleRecord)
    {
        _recView.croRecordModel = croRecordModel;
    }
    
    _valueArray[0].text = croRecordModel.projectOrderId;
    _valueArray[1].text = @"1 BTC = 10.000.000 POT";
    //TPString(@"1%@ = %@%@",croRecordModel.projectName,croRecordModel.ratio,croRecordModel.baseTokenName);
    _valueArray[2].text = TPString(@"%@%%",croRecordModel.releaseValue);
    _valueArray[3].text = TPString(@"%@/%@ %@",croRecordModel.successPayed,croRecordModel.price,croRecordModel.baseTokenName);
    _valueArray[4].text = TPString(@"%@/%@ %@",croRecordModel.value,croRecordModel.successValue,croRecordModel.tokenName);
    
    _valueArray[5].text = [croRecordModel.stopAt conversionTimeStamp];
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
    
//    self.timeLab.backgroundColor = [UIColor orangeColor];
//    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.equalTo(@20);
//        make.top.equalTo(@100);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//    }];
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
