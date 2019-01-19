//
//  YUSearchBarView.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/2.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUSearchBarView : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextfield;
@property (strong,nonatomic) void (^onTextChange)(NSString *text);
@property (strong,nonatomic) void (^onTextDidEndEditing)(id sender);
@property (strong,nonatomic) void (^onTextKeyboardReturn)(NSString *text);
@property (copy, nonatomic) NSString *placeholder;

- (void)fadeOut:(void(^)(void))complete;
- (void)fadeIn:(void(^)(void))complete;
- (void)tobeCircle;

@end


