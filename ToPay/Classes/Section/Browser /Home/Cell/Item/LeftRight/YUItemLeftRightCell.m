//
//  YUItemLeftRightCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUItemLeftRightCell.h"
#import "YUItemLeftRightCellEntity.h"
@interface YUItemLeftRightCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation YUItemLeftRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUItemLeftRightCellEntity *myEn = (YUItemLeftRightCellEntity*)entity;
    [self.leftLabel setText:myEn.leftStr];
    [self.rightLabel setText:myEn.rightStr];
    if (myEn.isAlignCenterStyle) {
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.rightLabel.textAlignment = NSTextAlignmentCenter;
        [self.leftLabel  setTextColor:[UIColor colorWithHex:@"#595971"]];
         [self.rightLabel  setTextColor:[UIColor colorWithHex:@"#595971"]];
    }else {
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        [self.leftLabel  setTextColor:[UIColor colorWithHex:@"#8E8E9E"]];
        [self.rightLabel  setTextColor:[UIColor colorWithHex:@"#8E8E9E"]];
    }
    
    if (myEn.rightFont ){
        [self.rightLabel setFont:myEn.rightFont];
    }else {
        [self.rightLabel setFont:[UIFont systemFontOfSize:13]];
    }
    
    if (myEn.rightColor) {
        [self.rightLabel setTextColor:myEn.rightColor];
    }else {
        [self.rightLabel setTextColor:[UIColor colorWithHex:@"#595971"]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
