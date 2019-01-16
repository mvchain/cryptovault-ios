//
//  TPMemonicStatusCollectionViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/15.
//  Copyright © 2019年 蒲公英. All rights reserved.
//
#import "UIView+YUStyle.h"
#import "TPMemonicStatusCollectionViewCell.h"
@interface TPMemonicStatusCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation TPMemonicStatusCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.titleLabel yu_circleStyle];
    self.titleLabel.layer.cornerRadius = 15;
    
    // Initialization code
}
- (void)setModel:(TPMemonicStatusCollectionViewCellModel *)model {
    [self.titleLabel setText:model.title];
    if (model.isSelected) {
        [self seletedStatus];
    }else {
        [self unSelectedStatus];
    }
}
- (void)seletedStatus {
    [self.titleLabel setBackgroundColor:[UIColor colorWithHex:@"#8383AF"]];
    [self.titleLabel setTextColor:[UIColor colorWithHex:@"#FFFFFF"]];
    
}
- (void)unSelectedStatus {
    [self.titleLabel setBackgroundColor:[UIColor colorWithHex:@"#F6F7FB"]];
    [self.titleLabel setTextColor:[UIColor colorWithHex:@"#8E8E9E"]];

}
- (void)toBecircle {
    [self.titleLabel yu_circleStyle];
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
}

@end
