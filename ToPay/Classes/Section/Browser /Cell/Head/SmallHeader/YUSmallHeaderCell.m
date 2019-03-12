//
//  YUSmallHeaderCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUSmallHeaderCell.h"
#import "YUSmallHeaderCellEntity.h"

@interface YUSmallHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *thisTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

@end


@implementation YUSmallHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUSmallHeaderCellEntity *myEn = (YUSmallHeaderCellEntity*)entity;
    if (myEn.isShoMore ) {
        [self showRight];
    }else {
        [self hideRight];
    }
    self.thisTitleLabel.text = myEn.title;
    
}
- (void)showRight {
    self.moreLabel.hidden = NO;
    self.rightArrow.hidden = NO;
}
- (void) hideRight {
    self.moreLabel.hidden = YES;
    self.rightArrow.hidden =YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
