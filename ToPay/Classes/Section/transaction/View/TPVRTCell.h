//
//  TPVRTCell.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPVRTModel.h"
@interface TPVRTCell : UITableViewCell

@property (nonatomic, strong) TPVRTModel *VRTModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier currName:(NSString *)currName;
@end
