//
//  TPMVCBankItemCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPMVCBankItemCell.h"
#import "TPMVCBankItemModel.h"
#import "TPMVCBankItemCellEntity.h"
@interface TPMVCBankItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *mimageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TPMVCBankItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    TPMVCBankItemCellEntity *myEntity = (TPMVCBankItemCellEntity *)entity ;
    TPMVCBankItemModel *model = (TPMVCBankItemModel *)entity.data;
    
    [self.mimageView sd_setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"portrait_icon"]];
    [self.leftLabel setText:model.nickname];
    [self.rightLabel setText:TPString(@"%.6f %@",[model.price doubleValue],myEntity.tokenName)];
    [self.downLabel setText:TPString(@"剩余可购买：%.6f MVC",model.limitValue)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
