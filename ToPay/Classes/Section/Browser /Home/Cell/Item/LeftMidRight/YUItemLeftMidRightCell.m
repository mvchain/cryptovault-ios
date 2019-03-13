//
//  YUItemLeftMidRightCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUItemLeftMidRightCell.h"
#import "YUItemLeftMidRightCellEntity.h"
@interface YUItemLeftMidRightCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation YUItemLeftMidRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUItemLeftMidRightCellEntity *myEn = (YUItemLeftMidRightCellEntity*)entity;
    [self.leftLabel setText:myEn.leftStr];
    [self.midLabel setText:myEn.mideStr];
    [self.rightLabel setText:myEn.rightStr];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
