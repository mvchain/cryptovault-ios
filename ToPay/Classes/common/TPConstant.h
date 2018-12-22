//
//  TPConstant.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/29.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/*
 * YYCache 存储名字
 */
UIKIT_EXTERN NSString * const TPCacheName;

/*
 * 基本信息
 */
UIKIT_EXTERN NSString * const TPUserInfoKey;

/*
 * 币种列表数据
 */
UIKIT_EXTERN NSString * const TPCurrencyListKey;

/*
 * 法币汇率数据
 */
UIKIT_EXTERN NSString * const TPLegalCurrencyListKey;

/*
 * 当前使用的法币汇率 符号
 */
UIKIT_EXTERN NSString * const TPNowLegalCurrencyKey;
UIKIT_EXTERN NSString * const TPNowLegalSymbolKey;
UIKIT_EXTERN NSString * const TPNowLegalNameKey;

/*
 * 交易对信息存储  VRT  余额
 */
UIKIT_EXTERN NSString * const TPPairBalanceKey;
UIKIT_EXTERN NSString * const TPPairVRTKey;

/*
 * 币种比值
 */
UIKIT_EXTERN NSString * const TPCurrencyRatioKey;

/*
 * 总资产数据
 */
UIKIT_EXTERN NSString * const TPBalanceDefaultKey;

/*
 * 通知时间戳
 */
UIKIT_EXTERN NSString * const TPNotificationTimeStampKey;

/**
 *  全局细线高度 .75f
 */
UIKIT_EXTERN CGFloat const MHGlobalBottomLineHeight;

/*
 * 币种修改成功通知
 */
UIKIT_EXTERN NSString * const TPPutCurrencyNotification ;

/*
 * 余额取出成功通知
 */
UIKIT_EXTERN NSString * const TPTakeOutSuccessNotification ;


/*
 * 法币切换通知
 */
UIKIT_EXTERN NSString * const TPLegalSwitchNotification ;


