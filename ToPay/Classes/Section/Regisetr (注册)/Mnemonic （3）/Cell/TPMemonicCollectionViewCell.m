//
//  TPMemonicCollectionViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMemonicCollectionViewCell.h"


@interface TPMemonicCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation TPMemonicCollectionViewCell

- (void)setTitle:(NSString *)title {
    [self.titleLabel setText:title];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
