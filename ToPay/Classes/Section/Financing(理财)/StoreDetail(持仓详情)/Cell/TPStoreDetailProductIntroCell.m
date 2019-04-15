//
//  TPStoreDetailProductIntroCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPStoreDetailProductIntroCell.h"
#import "MyStoreDetailBigInfoModel.h"
@interface TPStoreDetailProductIntroCell()
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *revuneLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottom_left_labe;
@property (weak, nonatomic) IBOutlet UILabel *bottom_middle_label;
@property (weak, nonatomic) IBOutlet UILabel *bottom_right_label;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *checkBgView;



@end

@implementation TPStoreDetailProductIntroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView yu_smallCircleStyleWithRadius:7];
    // Initialization code
}

- (void)setEntity:(YUCellEntity *)entity
{
    [super setEntity:entity];
    MyStoreDetailBigInfoModel *model = (MyStoreDetailBigInfoModel *)entity.data;
    [self.productNameLabel setText:model.financialName];
    [self.revuneLabel setText:TPString(@"年化收益率：%.2f-%.2f%%",model.incomeMin,model.incomeMax)];
    [self.bottom_left_labe setText:TPString(@"%.4f %@",model.income,model.tokenName)];
    [self.bottom_middle_label setText:TPString(@"%.4f %@",model.value,model.baseTokenName)];
    [self.bottom_right_label setText:TPString(@"剩余签到%ld天",(long)model.times)];
    [_checkBgView yu_smallCircleStyle];
    [_checkBgView yu_boarderStyle:[UIColor whiteColor]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
