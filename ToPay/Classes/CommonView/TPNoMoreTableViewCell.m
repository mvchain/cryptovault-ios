//
//  TPNoMoreTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/5.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPNoMoreTableViewCell.h"
@interface TPNoMoreTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TPNoMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    
    // Initialization code
}
- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    if (entity.data) {
        NSString *str= (NSString *)entity.data;
        if ([str isEqualToString:@"fin"]) {
            _bgView.hidden = NO;
            self.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
            
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
