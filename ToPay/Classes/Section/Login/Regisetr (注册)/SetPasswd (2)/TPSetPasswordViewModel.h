//
//  TPSetPasswordViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPRegisterInfoModel.h"


@interface TPSetPasswordViewModel : NSObject
@property (strong,nonatomic) TPRegisterInfoModel *regInfoModel;
#pragma http service
/**
 * 完成注册接口
 */
- (void)registerWithRegInfoModel:(TPRegisterInfoModel *)regInfoModel
                        complete:(void(^)(BOOL isSucc,NSString *reasonInfo))complete;

#pragma mark local method
- (void)isPassWordVaildWithPassWd:(NSString *)passWd
                        payPassWd:(NSString *)payPassWd
                      quickResult:(void(^)(BOOL isVaild,NSString *reasonInf))quickResult;

/**
 * 缓存注册对象
 */
- (void)setRegInfoModelToCache:(TPRegisterInfoModel *)infoModel;
@end

