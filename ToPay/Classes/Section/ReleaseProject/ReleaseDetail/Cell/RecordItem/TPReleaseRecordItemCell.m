//
//  TPReleaseRecordItemCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPReleaseRecordItemCell.h"
#import "M_ReleaseProjectRecordItem.h"
@interface TPReleaseRecordItemCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@end
@implementation TPReleaseRecordItemCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    M_ReleaseProjectRecordItem *item = (M_ReleaseProjectRecordItem*)entity.data;
    NSString *timeStr = [QuickMaker timeWithFormat:@"yyyy.MM.dd" time:item.createdAt];
    [_leftLabel setText:timeStr];
    [_rightLabel setText:TPString(@"+%.4f %@",item.value,item.tokenName)];
    
}
@end
