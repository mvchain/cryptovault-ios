//
//  NIMScannerViewController.h
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//


#import "NIMScanerCardViewController.h"
#import "TPStartViewController.h"
@interface NIMScannerViewController : TPStartViewController
@property (copy,nonatomic) NSString *tokenid;

/// 实例化扫描控制器
///
/// @param cardName   名片字符串
/// @param avatar     头像图片
/// @param completion 完成回调
///
/// @return 扫描控制器
- (instancetype)initWithCardName:(NSString *)cardName avatar:(UIImage *)avatar completion:(void (^)(NSString *stringValue))completion;
@end
