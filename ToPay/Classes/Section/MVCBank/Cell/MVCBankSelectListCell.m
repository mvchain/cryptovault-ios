//
//  MVCBankSelectListCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "MVCBankSelectListCell.h"
#import "MVCBankSelectListCellEntity.h"
@interface MVCBankSelectListCell()
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;

@end

@implementation MVCBankSelectListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    MVCBankSelectListCellEntity *myEntity = (MVCBankSelectListCellEntity *)entity;
    [self.myTitleLabel setText:myEntity.title];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
