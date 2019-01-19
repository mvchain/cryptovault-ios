//
//  TPInviteRegFirstPageTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInviteRegFirstPageTableViewCell.h"
#import "TPInviteRegFirstPageTableViewCellEntity.h"

@interface TPInviteRegFirstPageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *invitedCodeLabel;
@property (weak, nonatomic) IBOutlet UIView *firstRectView;
@property (weak, nonatomic) IBOutlet UIView *secondRectView;

@end

@implementation TPInviteRegFirstPageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setEntity:(YUCellEntity *)entity {
    
    [super setEntity:entity];
    [_firstRectView yu_smallCircleStyle];
    [_secondRectView yu_smallCircleStyle];
    TPInviteRegFirstPageTableViewCellEntity *entity_s = (TPInviteRegFirstPageTableViewCellEntity *)entity;
    self.invitedCodeLabel.text = entity_s.inviteCode;
}
@end
