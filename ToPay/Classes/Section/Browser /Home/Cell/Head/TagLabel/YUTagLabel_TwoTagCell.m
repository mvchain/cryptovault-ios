//
//  YUTagLabel_TwoTagCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTagLabel_TwoTagCell.h"
#import "YUTagLabel_TwoTagCellEntity.h"
@interface YUTagLabel_TwoTagCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@end


@implementation YUTagLabel_TwoTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUTagLabel_TwoTagCellEntity *myEn = (YUTagLabel_TwoTagCellEntity*)entity ;
    [self.leftLabel setText:myEn.leftStr];
    [self.rightLabel setText:myEn.rightStr];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
