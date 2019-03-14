//
//  YUBrowserHeadCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBrowserHeadCell.h"
#import "YUBrowserHeadCellEntity.h"
@interface YUBrowserHeadCell()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *blockHeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *transactionLabel;
@end

@implementation YUBrowserHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView yu_smallCircleStyle];
 
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUBrowserHeadCellEntity* myEn = (YUBrowserHeadCellEntity *)entity;
    [self.blockHeightLabel setText:@(myEn.blockHeight).stringValue];
    [self.transactionLabel setText:@(myEn.transnum).stringValue];
    [self.confirmTimeLabel setText:TPString(@"%@ S",@(myEn.confirmSecond).stringValue)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
