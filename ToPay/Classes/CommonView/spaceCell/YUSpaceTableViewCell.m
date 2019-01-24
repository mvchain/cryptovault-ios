//
//  YUSpaceTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/24.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUSpaceTableViewCell.h"
#import "YUSpaceTableViewCellEntity.h"
@implementation YUSpaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUSpaceTableViewCellEntity *en = (YUSpaceTableViewCellEntity *)entity;
    self.backgroundColor = en.bgcolor;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
