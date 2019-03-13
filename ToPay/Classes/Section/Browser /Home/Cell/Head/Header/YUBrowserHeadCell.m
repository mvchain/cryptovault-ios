//
//  YUBrowserHeadCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBrowserHeadCell.h"
@interface YUBrowserHeadCell()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *blockHeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionLabel;
@end

@implementation YUBrowserHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.stackView yu_smallCircleStyle];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
