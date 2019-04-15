//
//  TPAnnouncementView.h
//  ToPay
//
//  Created by 蒲公英 on 2019/4/12.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPAnnouncementView : UIView
@property (strong,nonatomic) NSArray <NSString *> *titles ;
@property (strong,nonatomic) void (^tap)(int index);
- (void)startAnimate;

@end

NS_ASSUME_NONNULL_END
