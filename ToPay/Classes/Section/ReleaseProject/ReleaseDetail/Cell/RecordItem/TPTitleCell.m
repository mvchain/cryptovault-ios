//
//  TPTitleCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPTitleCell.h"
@interface TPTitleCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TPTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    [_bgView yu_smallCircleStyle];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
