//
//  YUTextView.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUTextViewXibContainer.h"
@interface YUTextView : UIView
@property (strong, nonatomic) YUTextViewXibContainer *xibContainer;
@property (assign, nonatomic) BOOL autoHideHint; //自动隐藏顶部提示

- (NSString *)text;
- (void)setHintText:(NSString *)text;
- (void)setPlaceHolder:(NSString *)text;
- (void)showHintLabelWithIsAnimate:(BOOL)isAnimate;
- (void)hideHintLabelWithIsAnimate:(BOOL)isAnimate;
@end


