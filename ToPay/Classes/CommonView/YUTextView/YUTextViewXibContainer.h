//
//  YUTextViewXibContainer.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/16.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YUTextViewXibContainer : UIView
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *underLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_labelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_textFieldTop;
@end


