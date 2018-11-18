//
//  YFactoryUI.h
//  YiU
//
//  Created by FengKun on 2017/10/31.
//  Copyright © 2017年 蒲公英&守候. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFactoryUI : NSObject

/** 创建UILabel */
+ (UILabel *)YLableWithText:(NSString *)text
                      color:(UIColor *)color
                       font:(UIFont *)font;
//              textAlignment:(NSTextAlignment)textAlignment;
/** 创建UITextField */
+ (UITextField *)YTextFieldWithPlaceholder:(NSString *)placeholder
                               color:(UIColor *)color
                                font:(UIFont *)font
                     secureTextEntry:(BOOL)secureTextEntry
                            delegate:(id)delegate;

/** 创建UITextView */
+ (UITextView *)YTextViewWithText:(NSString *)text
                             color:(UIColor *)color
                             font:(UIFont *)font;
//                     textAlignment:(NSTextAlignment)textAlignment;

/** 创建UIButton */
+ (UIButton *)YButtonWithTitle:(NSString *)title
                         Titcolor:(UIColor *)color
                          font:(UIFont *)font
                         Image:(UIImage *)Image
                        target:(id)target
                        action:(SEL)action;

/** 创建图片 */
+ (UIImageView*)YImageViewWithimage:(UIImage*)image ;

/** 创建背景图片 */
+ (UIImage*)YimageWithColor:(UIColor*)color;

@end
