//
//  TPMyStoreItemCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMyStoreItemCell.h"
#import "MyStoreItemModel.h"
#import "TPMyStoreItemCellEntity.h"
@interface TPMyStoreItemCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftInfoLabel;

@end
@implementation TPMyStoreItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_bgView yu_smallCircleStyleWithRadius:7];
}

- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    TPMyStoreItemCellEntity *entity_s = (TPMyStoreItemCellEntity*)entity;
    if (entity_s.financialType == 1) {
        [self.leftInfoLabel setText:@"今日收益"];
    }else {
        [self.leftInfoLabel setText:@"累计收益"];
    }
    MyStoreItemModel *dataModel = (MyStoreItemModel *)entity.data;
    [_productNameLabel setText:dataModel.name];
    [_leftLabel setText:TPString(@"剩余签到%ld天",dataModel.times)];
    [_middleLabel setText:TPString(@"%.4lf %@",dataModel.value,dataModel.baseTokenName)];
    [_rightLabel setText:TPString(@"%.4lf %@",dataModel.partake,dataModel.baseTokenName)];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
