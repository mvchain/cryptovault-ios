//
//  TPFinancingProductDetailTotalCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/10.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPFinancingProductDetailTotalCell.h"
#import "ProgressView.h"
#import "FinProductDetailModel.h"
@interface TPFinancingProductDetailTotalCell()
@property (weak, nonatomic) IBOutlet UILabel *persentLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation TPFinancingProductDetailTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView yu_smallCircleStyle];
    
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    if (!entity.data)return ;
    FinProductDetailModel *res = (FinProductDetailModel *)entity.data;
    NSString *persent = TPString(@"%.2f-%.2f%%",res.incomeMin,res.incomeMax);
    [self.persentLabel setText:persent];
    [self.daysLabel setText:TPString(@"%ld 天",res.times)];
    [self.beginCashLabel setText:@"起投金额"];
    [self.beginCashLabel setText:TPString(@"%.4f %@",res.minValue,res.baseTokenName)];
    CGFloat remain = res.limitValue - res.sold;
    [self.remainLabel setText:TPString(@"剩余总额度%.4f %@",remain,res.baseTokenName)];
    CGFloat p = remain / res.limitValue;
    [self.progressView setPersent:p];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
