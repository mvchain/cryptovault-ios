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
    for(UIButton *btn  in @[_captialButton,_recordButton] ) {
            [btn setBackgroundColor:[UIColor colorWithHex:@"#EE6144"]];
            [btn.titleLabel setTextColor:[UIColor whiteColor]];
            [btn yu_circleStyle];
    }
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    YUPublicKeySearchResultCellEntity *myen = (YUPublicKeySearchResultCellEntity*)entity;
    self.publicKeyContentLabel.text = myen.publicKey;
}
- (IBAction)captial_ta:(id)sender {
    [self.yu_delegate yu_cellMessageNotify:@"cap" content:self.entity sender:nil];
}
- (IBAction)recordTap:(id)sender {
     [self.yu_delegate yu_cellMessageNotify:@"rec" content:self.entity sender:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
