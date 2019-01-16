//
//  YUTextView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTextView.h"

#import "UIView+YUStyle.h"
@interface YUTextView()<UITextFieldDelegate>


@end
@implementation YUTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.autoHideHint = YES;
    self.xibContainer = [YUTextViewXibContainer xib_loadUsingClassName];
    [self addSubview:self.xibContainer];
    [self.xibContainer.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self hideHintLabelWithIsAnimate:NO];
}
   

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.xibContainer.frame = self.bounds;
}

- (NSString *)text {
    return self.xibContainer.textField.text;
}

- (void)setPlaceHolder:(NSString *)text {
    self.xibContainer.textField.placeholder = text;
}

- (void)setHintText:(NSString *)text {
    self.xibContainer.hintLabel.text = text;
}
- (void)showHintLabelWithIsAnimate:(BOOL)isAnimate {
    if (self.xibContainer.hintLabel.alpha == 1) return ;
    if (isAnimate) {
        [UIView animateWithDuration:0.37 animations:^{
            self.xibContainer.hintLabel.alpha = 1;
        }];
    }else {
        self.xibContainer.hintLabel.alpha = 1;
    }
}

- (void)hideHintLabelWithIsAnimate:(BOOL)isAnimate {
    if (self.xibContainer.hintLabel.alpha == 0) return ;
    self.xibContainer.hintLabel.alpha = 1 ;
    if (isAnimate) {
        [UIView animateWithDuration:0.37 animations:^{
           self.xibContainer.hintLabel.alpha = 0;
        }];
    }else {
        self.xibContainer.hintLabel.alpha = 0;
    }
}

#pragma mark event
- (void)textFieldChanged:(UITextField*)textField{
    if (textField.text.length >0) {
        [self showHintLabelWithIsAnimate:YES];
    }else {
        [self hideHintLabelWithIsAnimate:YES];
    }
}
@end
