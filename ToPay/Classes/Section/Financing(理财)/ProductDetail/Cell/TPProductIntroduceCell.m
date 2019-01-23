//
//  TPProductIntroduceCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPProductIntroduceCell.h"
#import "TPProductIntroduceCellEntity.h"
@interface TPProductIntroduceCell()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TPProductIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    TPProductIntroduceCellEntity *en = (TPProductIntroduceCellEntity *)entity;
    [self.contentLabel setText:en.content];
    [self.titleLabel setText:en.title];
    [_bgView yu_smallCircleStyle];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
