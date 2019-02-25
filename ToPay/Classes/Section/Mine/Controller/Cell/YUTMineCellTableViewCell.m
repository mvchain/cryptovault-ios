//
//  YUTMineCellTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/24.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTMineCellTableViewCell.h"
#import "YUTMineCellTableViewCellEntity.h"
@interface YUTMineCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftIMageView;
@property (weak, nonatomic) IBOutlet UILabel *midTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgVIew;

@end

@implementation YUTMineCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    if (entity.indexpath.row == 0 ) {
        [_bgVIew yu_smallCircleStyle];
    }else {
        _bgVIew.layer.cornerRadius=0;
        
        _bgVIew.layer.masksToBounds=NO;//隐藏裁剪掉的部分
    }
    YUTMineCellTableViewCellEntity *en = (YUTMineCellTableViewCellEntity *)entity;
    [_leftIMageView setImage:en.image];
    [_midTitleLabel setText:en.title];
    
}
@end
