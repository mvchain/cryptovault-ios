//
//  YFactoryUI.m
//  YiU
//
//  Created by FengKun on 2017/10/31.
//  Copyright © 2017年 蒲公英&守候. All rights reserved.
//

#import "YFactoryUI.h"

@implementation YFactoryUI

/** 创建UILabel */
+ (UILabel *)YLableWithText:(NSString *)text
                       color:(UIColor *)color
                        font:(UIFont *)font
//               textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.clipsToBounds = YES;
    label.text = text;
    label.textColor = color;
    label.font = font;
    return label;
}
/** 创建UITextField */
+ (UITextField *)YTextFieldWithPlaceholder:(NSString *)placeholder
                                     color:(UIColor *)color
                                      font:(UIFont *)font
                           secureTextEntry:(BOOL)secureTextEntry
                                  delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc]init];
    textField.clipsToBounds = YES;
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = font;
    textField.secureTextEntry = secureTextEntry;
    textField.delegate = delegate;
    
    return textField;
}

/** 创建UITextView */
+ (UITextView *)YTextViewWithText:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
//                    textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] init];
    textView.text = text;
    textView.clipsToBounds = YES;
//    textView.textAlignment = textAlignment;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    
    paragraphStyle.lineSpacing = 12;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    
  
    textView.textColor = color;
    
//    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
   
    return textView;
}

/** 创建UIButton */
+ (UIButton *)YButtonWithTitle:(NSString *)title
                         Titcolor:(UIColor *)color
                          font:(UIFont *)font
                         Image:(UIImage *)Image
                        target:(id)target
                        action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    btn.clipsToBounds = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    if (!color) {[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];}else
    {[btn setTitleColor:color forState:UIControlStateNormal];}
//    btn.backgroundColor =YRandomColor;
    [btn.titleLabel setFont:font];
    [btn setImage:Image forState:UIControlStateNormal];//setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

/** 创建图片 */
+ (UIImageView*)YImageViewWithimage:(UIImage*)image
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.clipsToBounds = YES;
//    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
//    imgView.backgroundColor = YRandomColor;
    return imgView;
}

/** 创建背景图片 */
+ (UIImage*)YimageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
