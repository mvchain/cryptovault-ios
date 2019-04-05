//
//  MVCBankCoinSelectView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/4.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "MVCBankCoinSelectView.h"
@interface MVCBankCoinSelectView()
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation MVCBankCoinSelectView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView yu_boarderStyle:[UIColor colorWithHex:@"#707070"]];
    [self.bgView yu_smallCircleStyle];
}
- (IBAction)tap:(id)sender {
    if (self.tap)self.tap(sender);
}
@end
