//
//  TPTransDetailCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/27.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTransDetailCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isCopy:(BOOL)isCopy;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * conLab;
@end
