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
@property (weak, nonatomic) IBOutlet UIButton *mcopyInvitedCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *mcopyDownLoadBtn;
@property (weak, nonatomic) IBOutlet UIButton *myInvitedBtm;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mimageView;
@end
@implementation TPInviteRegFirstPageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_mcopyDownLoadBtn clarityStyle];
    [_mcopyInvitedCodeBtn clarityStyle];
    [_myInvitedBtm gradualChangeStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

- (void)setEntity:(YUCellEntity *)entity {
    
    [super setEntity:entity];
    [_firstRectView yu_smallCircleStyle];
    [_secondRectView yu_smallCircleStyle];
    TPInviteRegFirstPageTableViewCellEntity *entity_s = (TPInviteRegFirstPageTableViewCellEntity *)entity;
    self.invitedCodeLabel.text = entity_s.inviteCode;
    self.mimageView.image = entity_s.qrimage;
    if(entity_s.qucikShotMode == YES) {
        self.myInvitedBtm.hidden = YES;
        self.mcopyDownLoadBtn.hidden = YES;
        self.mcopyInvitedCodeBtn.hidden= YES;
    
    }else {
        self.myInvitedBtm.hidden = NO;
        self.mcopyDownLoadBtn.hidden =NO;
        self.mcopyInvitedCodeBtn.hidden= NO;
    }
    [_websiteLabel setText:entity_s.website];
    
}
- (IBAction)copyDownLoadAddrTap:(id)sender {
    if(self.entity.callBackByCell) {
        self.entity.callBackByCell(@{@"from":@"copy-download-addr"});
    }
}
- (IBAction)copyInvitedCdoeTap:(id)sender {
    if(self.entity.callBackByCell) {
        self.entity.callBackByCell(@{@"from":@"copy-invited-code"});
    }
}

- (IBAction)myInvitedTap:(id)sender {
    if(self.entity.callBackByCell) {
        self.entity.callBackByCell(@{@"from":@"my-invited"});
    }
}
@end
