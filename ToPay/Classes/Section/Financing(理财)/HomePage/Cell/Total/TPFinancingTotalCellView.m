//
//  TPFinancingTotalCellView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/21.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPFinancingTotalCellView.h"
#import "FinProductDetailModel.h"
#import "BlanaceResponse.h"
@interface TPFinancingTotalCellView()
@property (weak, nonatomic) IBOutlet UILabel *leftUpLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPartSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPartBigLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPartSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPartBigLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation TPFinancingTotalCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.backView yu_smallCircleStyleWithRadius:7];
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    
    if ([entity.data isKindOfClass:BlanaceResponse.class]) {
        [self homeStyle];
        BlanaceResponse *res = (BlanaceResponse *)entity.data;
        NSString *currency =  [QuickGet getLegalCurrency];
        NSString *total = [NSString stringWithFormat:@"%.2f",res.balance];
        [self.middleNumberLabel setText:total];
        NSString *leftP = TPString(@"%.2f %@",res.lastIncome,currency);
        NSString *rightP = TPString(@"%.2f %@",res.lastIncome,currency);
        [self.leftPartBigLabel setText:leftP];
        [self.rightPartBigLabel setText:rightP];
    }else if( [entity.data isKindOfClass:FinProductDetailModel.class] ) {
        [self productDetailStyle];
        FinProductDetailModel *res = (FinProductDetailModel *)entity.data;
        NSString *currency =  [QuickGet getLegalCurrency];
        [self.middleTitleLabel setText:@"预期年化收益率"];
        NSString *persent = TPString(@"%.2f-%.2f%%",res.incomeMin,res.incomeMax);
        [self.middleNumberLabel setText:persent];
        [self.leftPartSmallLabel setText:@"理财周期"];
        [self.leftPartBigLabel setText:TPString(@"%ld",res.times)];
        [self.rightPartSmallLabel setText:@"起投金额"];
        [self.rightPartBigLabel setText:TPString(@"%.4f%@",res.minValue,res.baseTokenName)];
    }
}
- (void)homeStyle {
    // 首页style
    _leftUpLabel.hidden = NO;
    _moneyFlagLabel.hidden = NO;
}
- (void)productDetailStyle {
    // 产品详情页style
    _leftUpLabel.hidden = YES;
    _moneyFlagLabel.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
