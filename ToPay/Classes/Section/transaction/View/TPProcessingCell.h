//
//  TPProcessingCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/23.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TPStatusStyle)
{
    TPStatusStyleProcessing,  // 进行中
    TPStatusStylecarryOut,   // 完成
};

@interface TPProcessingCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPStatusStyle)statusStyle;


@end
