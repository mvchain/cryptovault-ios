//
//  YUMineLoginOutCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/24.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUMineLoginOutCell.h"
@interface YUMineLoginOutCell()
@property (weak, nonatomic) IBOutlet UIView *bg;

@end

@implementation YUMineLoginOutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_bg yu_smallCircleStyle];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
