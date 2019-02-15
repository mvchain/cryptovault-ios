//
//  YUAlertViewController.h
//  Photo
//
//  Created by yxyyxy on 16/06/2018.
//  Copyright © 2018 叶夏云. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUAlertViewController;

/**
 显示的样式

 - YUAlertViewApperanceTypeNormal: 普通正常
 - YUAlertViewApperanceTypeDanager: 危险操作紧急，比如删除
 - YUAlertViewApperanceTypeNotification: 信息通知
 - YUAlertViewApperanceTypeWaring: 警告
 - YUAlertViewApperanceTypeNetError: 网络错误
 - YUAlertViewApperanceTypeError: 出现了一个错误
 */
typedef NS_ENUM(NSInteger,YUAlertViewApperanceType){
    YUAlertViewApperanceTypeNormal = 0,
    YUAlertViewApperanceTypeDanager = 1 ,
    YUAlertViewApperanceTypeNotification = 2,
    YUAlertViewApperanceTypeWaring = 3,
    YUAlertViewApperanceTypeNetError = 4,
    YUAlertViewApperanceTypeCamera = 5,
};

/**
 alert选项

 - YUAlertViewApperanceOptionNoneImage: 不显示图片
 - YUAlertViewApperanceOptionBackgroundDismiss: 点击遮照层退出
 */
typedef NS_OPTIONS(NSInteger, YUAlertViewApperanceOption){
    
    YUAlertViewApperanceOptionNoneImage = 1 << 4 ,
    YUAlertViewApperanceOptionBackgroundDismiss = 1 << 5
};


@interface YUAlertViewControllerStyle:NSObject


@property (copy,nonatomic) NSString *yu_alertTitle;
@property (copy,nonatomic) NSString *yu_alertContent;
@property (copy,nonatomic) UIImage * yu_alertInfoImage;
@property (assign,nonatomic) YUAlertViewApperanceType yu_apperanceType;
@end

@interface YUAlertViewControllerConfirmOnlyStyle:YUAlertViewControllerStyle
@property (copy,nonatomic) NSString *yu_confirmButtonTitle ;
@end

@interface YUAlertViewControllerCancelWithConfirmStyle:YUAlertViewControllerStyle
@property (copy,nonatomic) NSString *yu_confirmButtonTitle ;
@property (copy,nonatomic) NSString *yu_cancleButtonTitle ;
@end

@interface YUMethod:NSObject
@property (weak,nonatomic) id object;
@property (assign,nonatomic) SEL msg_selector ;
@property (strong,nonatomic) id withObjct_1 ;
@property (strong,nonatomic) id withObjct_2 ;

// 执行方法
- (void) exec ;
@end

@interface YUAlertViewController : UIViewController
- (void)yu_setting:(void(^)(YUAlertViewControllerCancelWithConfirmStyle * style)) styleMaker
     confirmAction:(void(^)(id sender ))confirmAction
      cancleAction:(void(^)(id sender ))cancleAction ;
- (void)yu_setting:(void(^)(YUAlertViewControllerConfirmOnlyStyle * style)) styleMaker
     confirmAction:(void(^)(id sender ))confirmAction;

@end
