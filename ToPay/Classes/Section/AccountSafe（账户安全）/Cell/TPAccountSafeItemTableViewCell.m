//
//  TPAccountSafeItemTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPAccountSafeItemTableViewCell.h"
#import "TPAccountSafeItemTableViewCellEntity.h"
@interface TPAccountSafeItemTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation TPAccountSafeItemTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setEntity:(YUCellEntity *)entity {
    TPAccountSafeItemTableViewCellEntity *entity_s = (TPAccountSafeItemTableViewCellEntity *)entity ;
    [self.titleLabel setText:entity_s.title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
