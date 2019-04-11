//
//  API_GET_Asset_inner.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/11.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "ServModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface API_GET_Asset_inner : ServModel
- (void)sendRequestWithAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
