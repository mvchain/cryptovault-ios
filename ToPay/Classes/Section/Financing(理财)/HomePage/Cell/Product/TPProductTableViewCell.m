//
//  TPProductTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPProductTableViewCell.h"
#import "TPProductTableViewCellEntity.h"
#import "FinancialProductModel.h"
@interface TPProductTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *rightSmall0Label;
@property (weak, nonatomic) IBOutlet UILabel *rightSmall1Label;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *rightSmall0BgView;
@property (weak, nonatomic) IBOutlet UIView *rightSmall1BgView;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *persentLabel;
@end

@implementation TPProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.rightSmall0BgView yu_boarderStyle:[UIColor colorWithHex:@"#8E8E9E"]];
    [self.rightSmall1BgView yu_boarderStyle:[UIColor colorWithHex:@"#8E8E9E"]];
    [self.rightSmall0BgView yu_smallCircleStyle];
    [self.rightSmall1BgView yu_smallCircleStyle];
    [_bgView yu_smallCircleStyle];
    
}

- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    FinancialProductModel *model = entity.data;
    [_productTitleLabel setText:model.name];
    NSString *persentStr = [NSString stringWithFormat:@"%.2f-%.2f%%",model.incomeMin,model.incomeMax];
    [_persentLabel setText:persentStr];
    [_orderTimeLabel setText:TPString(@"下线时间：%@",[QuickMaker timeWithTimeIntervalString:model.stopAt])];
    [_rightSmall1Label setText:[NSString stringWithFormat:@"签到%ld天",(long)model.times]];
    [_rightSmall0Label setText:[NSString stringWithFormat:@"%.f %@起投",model.minValue,model.baseTokenName]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
