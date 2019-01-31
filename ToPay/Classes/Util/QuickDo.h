//
//  QuickDo.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/4.
//  Copyright © 2019年 蒲公英. All rights reserved.
//
/**
 * Finds the top-most HUD subview that hasn't finished and hides it. The counterpart to this method is showHUDAddedTo:animated:.
 *
 * @note This method sets removeFromSuperViewOnHide. The HUD will automatically be removed from the view hierarchy when hidden.
 *
 * @param view The view that is going to be searched for a HUD subview.
 * @param animated If set to YES the HUD will disappear using the current animationType. If set to NO the HUD will not use
 * animations while disappearing.
 * @return YES if a HUD was found and removed, NO otherwise.
 *
 * @see showHUDAddedTo:animated:
 * @see animationType
 */
#import <Foundation/Foundation.h>

#define yudef_property_strong(type,name) @property (strong ,nonatomic) type* name;
#define yudef_property_copy(type,name) @property (copy ,nonatomic) type* name;
#define yudef_property_assign(type,name) @property (assign ,nonatomic) type name;
#define yudef_lazyLoad(type,name,_name) -(type *)name {if(!_name){_name = [[type alloc] init];}return _name;}
#define yudef_exit_func_if(condition) if(condition)return;
@interface QuickDo : NSObject
+ (void)shareToSystem:(NSArray *)items target:(id)target success:(void(^)(bool isok))successBlock ;
+ (void)setJPushAlians:(NSString *)aliansName ;
/**
 * 美观cell的分割线
 * 去掉尾行分割线
 * 左右分割线有空隙
 */
+ (void)prettyTableViewCellSeparate:(NSArray<NSNumber *> *)hideIndexs cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
+ (void)changeWindowKeyWindow:(UIViewController *)vc;
+ (void)swithchToMainTab;
+ (void)switchToGuiderPage ;
+ (void)logout ; //退出
+ (void)copyToPastboard:(NSString *)str ;
+ (void)entoForgetPayPwd:(UIViewController *)vc;
@end


