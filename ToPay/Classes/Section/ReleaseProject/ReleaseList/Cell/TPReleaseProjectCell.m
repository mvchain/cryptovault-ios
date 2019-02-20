//
//  TPReleaseProjectCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPReleaseProjectCell.h"
#import "ReleaseProjectItem.h"
@interface TPReleaseProjectCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *releasePersentLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation TPReleaseProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    [_bgView yu_smallCircleStyle];
    [_iconImageView yu_smallCircleStyle];
    
    ReleaseProjectItem *item = (ReleaseProjectItem *)entity.data;
    [_nameLabel setText:item.projectName];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.projectImage]];
    NSString *persentStr = TPString(@"每日释放比例 %.1f%%",item.releaseValue) ;
    NSString *timeStr = TPString(@"发币时间:%@",[QuickMaker timeWithTimeInterval_allNumberStyleString:item.publishTime]);
    [_releasePersentLabel setText:persentStr];
    [_releaseTimeLabel setText:timeStr];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
