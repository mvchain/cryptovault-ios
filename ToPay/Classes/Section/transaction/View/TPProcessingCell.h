//
//  TPProcessingCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/23.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPRecordModel.h"
#import "TPVRTModel.h"
typedef NS_ENUM(NSUInteger, TPStatusStyle)
{
    TPStatusStyleProcessing = 0,  // 进行中
    TPStatusStylecarryOut = 1,   // 完成
};

@interface TPProcessingCell : UITableViewCell

@property (nonatomic, strong) TPRecordModel *record;


@property (nullable, copy) void (^withdrawalBlock)(void);

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithStyle:(TPStatusStyle)statusStyle pairArr:(NSMutableArray<TPVRTModel *>*)pairArr;


@end
