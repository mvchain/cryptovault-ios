//
//  TPStoreEveryDayIncomeCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPStoreEveryDayIncomeCell.h"
#import "MyStoreDetailBigInfoModel.h"
#import "MyEveryDayIncomItemModel.h"
@interface TPStoreEveryDayIncomeCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@end
@implementation TPStoreEveryDayIncomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)firstStyle {
    
}
- (void)lastStyle {
    
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    MyEveryDayIncomItemModel *model = (MyEveryDayIncomItemModel *)entity.data;
    [self.leftLabel setText:[QuickMaker timeWithTimeIntervalString:model.createdAt]];
    [self.rightLabel setText:TPString(@"%.4lf%@",model.income,model.tokenName)];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
