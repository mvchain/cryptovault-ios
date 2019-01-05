//
//  YUTableViewCell.m
//  Forum
//
//  Created by yxyyxy on 02/04/2018.
//  Copyright © 2018 yxy. All rights reserved.
//

#import "YUTableViewCell.h"

@implementation YUTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setEntity:(YUCellEntity *)entity
{
    
    _entity= entity;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
