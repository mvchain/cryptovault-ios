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
 * 当前使用的法币汇率
 */
UIKIT_EXTERN NSString * const TPNowLegalCurrencyKey;


/*
 * 币种比值
 */
UIKIT_EXTERN NSString * const TPCurrencyRatioKey;

/*
 * 总资产数据
 */
UIKIT_EXTERN NSString * const TPBalanceDefaultKey;


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
