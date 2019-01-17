//
//  QuickDo.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/4.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "QuickDo.h"
#import <JPUSHService.h>
#import "TPGuiderViewController.h"
#import "YUTabBarController.h"
@implementation QuickDo

+ (void)setJPushAlians:(NSString *)aliansName  {
    [JPUSHService setAlias:aliansName completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%d%@%d",iResCode,iAlias,seq);
        
    } seq:0];
    
}
+ (void)shareToSystem:(NSArray *)items target:(id)target success:(void(^)(bool isok))successBlock {
    /*
     *  NSString *textToShare = @"mq分享";
     *  UIImage *imageToShare = [UIImage imageNamed:@"imageName"];
     *  NSURL *urlToShare = [NSURL URLWithString:@"https://www.baidu.com"];
     *  NSArray *items = @[urlToShare,textToShare,imageToShare];
     */
    if (items.count == 0 || target == nil) {
        return;
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    if (@available(iOS 11.0, *)) {//UIActivityTypeMarkupAsPDF是在iOS 11.0 之后才有的
        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypeOpenInIBooks,UIActivityTypeMarkupAsPDF];
    } else if (@available(iOS 9.0, *)) {//UIActivityTypeOpenInIBooks是在iOS 9.0 之后才有的
        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypeOpenInIBooks];
    }else {
        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeMail];
    }
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            if( successBlock )
                successBlock(YES);
        }else {
            if( successBlock )
                successBlock(NO);
        }
    };
    //这儿一定要做iPhone与iPad的判断，因为这儿只有iPhone可以present，iPad需pop，所以这儿actVC.popoverPresentationController.sourceView = self.view;在iPad下必须有，不然iPad会crash，self.view你可以换成任何view，你可以理解为弹出的窗需要找个依托。
    UIViewController *vc = target;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityVC.popoverPresentationController.sourceView = vc.view;
        [vc presentViewController:activityVC animated:YES completion:nil];
    } else {
        [vc presentViewController:activityVC animated:YES completion:nil];
    }
}

+ (void)prettyTableViewCellSeparate:(NSArray<NSNumber *> *)hideIndexs cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    BOOL hide = NO;
    for ( NSNumber *i in hideIndexs ) {
        if ( [i integerValue] == indexPath.row ) {
            hide = YES;
            break;
        }
    }
    if ( hide ) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, [UIScreen mainScreen].bounds.size.width);
    }else {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 16, 0, 16)];
        }
    }
    
}

+ (void)changeWindowKeyWindow:(UIViewController *)vc  {
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *dele = (AppDelegate*)app.delegate;
    dele.window.rootViewController = vc;
}

+ (void)switchToGuiderPage {
    UINavigationController *nav = [[UINavigationController alloc] init];
    nav.navigationBar.hidden = YES;
    [nav setNavigationBarHidden:YES];
    
    TPGuiderViewController *tp = [[TPGuiderViewController alloc] init];
    nav.viewControllers = @[tp];
    [self changeWindowKeyWindow:nav];
}

+ (void)swithchToMainTab {
    YUTabBarController *tab =[[YUTabBarController alloc]init];
    [self changeWindowKeyWindow:tab];
}
@end