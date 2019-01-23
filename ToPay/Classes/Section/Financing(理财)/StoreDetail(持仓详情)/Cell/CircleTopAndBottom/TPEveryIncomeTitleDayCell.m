//
//  TPEveryIncomeTitleDayCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPEveryIncomeTitleDayCell.h"

@interface TPEveryIncomeTitleDayCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation TPEveryIncomeTitleDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_bgView yu_smallCircleStyleWithRadius:7];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
