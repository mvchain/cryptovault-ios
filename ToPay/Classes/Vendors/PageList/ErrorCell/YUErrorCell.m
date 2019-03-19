//
//  YUErrorCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/2.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "YUErrorCell.h"

@interface YUErrorCell()
@property (weak, nonatomic) IBOutlet UILabel *mytextLabel;

@end 

@implementation YUErrorCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [self.mytextLabel setText:(NSString *)entity.data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
