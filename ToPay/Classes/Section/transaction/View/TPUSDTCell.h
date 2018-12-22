//
//  TPUSDTCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTransactionModel.h"
@interface TPUSDTCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier transType:(NSString *)transType tokenName:(NSString *)tokenName;

@property (nonatomic, strong) TPTransactionModel *transModel;
@end
