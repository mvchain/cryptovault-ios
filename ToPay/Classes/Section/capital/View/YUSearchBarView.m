//
//  YUSearchBarView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/2.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUSearchBarView.h"
#define ana_dur 0.37
@implementation YUSearchBarView
#pragma mark sys event
- (void)awakeFromNib{
    [super awakeFromNib];
    _searchTextfield.delegate = self ;
    [_searchTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchTextfield.returnKeyType = UIReturnKeySearch;
}
- (void)textFieldDidChange:(UITextField *)textfield {
    if( _onTextChange ) {
        _onTextChange(textfield.text);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if( _onTextDidEndEditing ) {
        _onTextDidEndEditing( textField );
    }
    
}
#pragma mark  custom event
- (void)fadeOut:(void(^)(void))complete {
    self.alpha = 1;
    [UIView animateWithDuration:ana_dur animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        complete();
        
    }];
}
- (void)fadeIn:(void(^)(void))complete {
    self.alpha = 0 ;
    [UIView animateWithDuration:ana_dur animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        complete();
        
    }];
}
- (void)tobeCircle{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.height /2 ;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if( _searchTextfield ) {
        _searchTextfield.placeholder = placeholder;
    }
}
@end
