//
//  TPInviteRegSecondPageItemTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/21.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInviteRegSecondPageItemTableViewCell.h"
#import "TPInviteRegSecondPageItemTableViewCellEntity.h"
@interface TPInviteRegSecondPageItemTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end 
@implementation TPInviteRegSecondPageItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    TPInviteRegSecondPageItemTableViewCellEntity *entity_s = (TPInviteRegSecondPageItemTableViewCellEntity*)entity;
    [_nameLabel setText:entity_s.userModel.nickname];
    [_timeLabel setText:[QuickMaker timeWithTimeIntervalString:entity_s.userModel.createdAt]];
    [super setEntity:entity];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
