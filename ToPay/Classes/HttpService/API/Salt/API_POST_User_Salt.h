//
//  API_POST_User_Salt.h
//  ToPay
//
//  Created by 蒲公英 on 2019/3/6.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "ServModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface API_POST_User_Salt : ServModel
- (void)sendRequestWithEmail:(NSString *)email;
@end

NS_ASSUME_NONNULL_END
