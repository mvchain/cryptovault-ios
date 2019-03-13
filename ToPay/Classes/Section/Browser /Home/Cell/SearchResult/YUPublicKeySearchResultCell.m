//
//  YUPublicKeySearchResultCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/13.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUPublicKeySearchResultCell.h"
#import "YUPublicKeySearchResultCellEntity.h"
@interface YUPublicKeySearchResultCell()
@property (weak, nonatomic) IBOutlet UIButton *captialButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *publicKeyContentLabel;

@end

@implementation YUPublicKeySearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [@[_captialButton,_recordButton] bk_apply:^(id obj) {
        UIButton *btn = (UIButton *)obj;
        [btn setBackgroundColor:[UIColor colorWithHex:@"#EE6144"]];
        [btn.titleLabel setTextColor:[UIColor whiteColor]];
        [btn yu_circleStyle];
    }];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
