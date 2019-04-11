//
//  UITableView+YUTableViewAddition.m
//  ShellKitDemo
//
//  Created by yxy on 2018/6/8.
//  Copyright © 2018 jimi. All rights reserved.
//

#import "UITableView+YUTableViewAddition.h"
@implementation UITableView (YUTableViewAddition)

- (void)registerCell:(Class)cls {
    
    NSString * cellStr = NSStringFromClass(cls);
    BOOL isNibExist = [self isNibExist:cls];
    if(isNibExist){
        UINib * nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:cellStr];
    }else{
        [self registerClass:cls forCellReuseIdentifier:cellStr];
    }
}

- (void)registerHeaderFooter:(Class )cls {
    
    NSString * cellStr = NSStringFromClass(cls);
    BOOL isNibExist = [self isNibExist:cls];
    if(isNibExist){
        UINib * nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[NSBundle mainBundle]];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:cellStr];
    }else{
        [self registerClass:cls forHeaderFooterViewReuseIdentifier:cellStr];
    }
}

- (BOOL)isNibExist:(Class)cls {
    
    NSString *className =NSStringFromClass(cls);
    BOOL isNibExist = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.nib",[[NSBundle mainBundle]resourcePath],className]];
    return isNibExist;
}

- (void)setRefreshBackGroundColor:(UIColor *)color  {
    yudef_weakSelf;
    
    [self bk_addObserverForKeyPath:@"contentOffset" task:^(id target) {
        CGFloat offy =  weakSelf.contentOffset.y ;
        if (offy<0) {
            UIView *view = [self refreshBackgroundView];
            [view setFrame:CGRectMake(0, offy, self.frame.size.width, -offy)];
            [view setBackgroundColor:color];
        }
    }];
}
- (UIView *)refreshBackgroundView {
    UIView *view = [self bk_associatedValueForKey:@"refresh"];
    if (!view) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.layer.zPosition = -10000;
        [self addSubview:view];
        [self bk_associateValue:view withKey:@"refresh"];
    }
    return view;
}
- (void)dealloc {
    [self bk_removeAllBlockObservers];
}
@end
