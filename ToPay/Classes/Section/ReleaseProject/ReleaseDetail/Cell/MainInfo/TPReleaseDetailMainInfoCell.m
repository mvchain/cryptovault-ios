//
//  TPReleaseDetailMainInfoCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPReleaseDetailMainInfoCell.h"
#import "M_ReleaseProjectJoinedDetail.h"
@interface TPReleaseDetailMainInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel; // 释放比例
@property (weak, nonatomic) IBOutlet UILabel *pay_orderLabel; // 支付/预约
@property (weak, nonatomic) IBOutlet UILabel *succ_orderLabel; //  成功/预约
@property (weak, nonatomic) IBOutlet UILabel *changeRatioLabel; // 兑换比例
@property (weak, nonatomic) IBOutlet UILabel *releaseTimelabel; // 发布时间
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation TPReleaseDetailMainInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImageView yu_smallCircleStyle];
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    M_ReleaseProjectJoinedDetail *detail = (M_ReleaseProjectJoinedDetail *)entity.data;
    if (!detail)return ;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:detail.projectImage]];
    [_pay_orderLabel setText:TPString(@"%.4f/%.4f",detail.successPayed,detail.payed)];
    [_succ_orderLabel setText:TPString(@"%.4f/%.4f",detail.successValue,detail.value)];
    [_changeRatioLabel setText:TPString(@"1 %@ = %.4f%@",detail.tokenName,detail.ratio,detail.baseTokenName)];
    [_releaseTimelabel setText:[QuickMaker timeWithTimeInterval_allNumberStyleString:detail.createdAt]];
    
    [_bgView yu_smallCircleStyle];
    [_nameLabel setText:detail.projectName];
    [_releaseLabel setText:TPString(@"%.3f",detail.releaseValue)];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
