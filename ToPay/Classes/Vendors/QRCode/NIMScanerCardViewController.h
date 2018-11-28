//
//  NIMScanerCardViewController.h
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NIMBaseViewController.h"

#import "TPStartViewController.h"

@interface NIMScanerCardViewController : TPStartViewController


- (instancetype)initWithCardName:(NSString *)cardName avatar:(UIImage *)avatar;

@end
