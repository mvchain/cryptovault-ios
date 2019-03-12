//
//  YUTagLabelCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTagLabelCell.h"
#import "YUTagLabelCellEntity.h"
@interface YUTagLabelCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@end

@implementation YUTagLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUTagLabelCellEntity *myEn = (YUTagLabelCellEntity *)entity;
    
    [self.leftLabel setText:myEn.leftStr];
    [self.midLabel setText:myEn.midStr];
    [self.rightLabel setText:myEn.rightStr];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
