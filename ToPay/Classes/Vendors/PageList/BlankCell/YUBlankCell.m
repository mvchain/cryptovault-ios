//
//  YUBlankCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/4.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "YUBlankCell.h"
#import "YUBlankCellEntity.h"
@implementation YUBlankCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUBlankCellEntity *blankEntity = (YUBlankCellEntity*)entity;
    if (blankEntity.bgColor)
        self.contentView.backgroundColor = blankEntity.bgColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
