//
//  QuickDo.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/4.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuickDo : NSObject
+ (void)shareToSystem:(NSArray *)items target:(id)target success:(void(^)(bool isok))successBlock ;


@end

NS_ASSUME_NONNULL_END
