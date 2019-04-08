//
//  API_POST_User_Salt.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/6.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "API_POST_User_Salt.h"

@implementation API_POST_User_Salt
- (void)sendRequestWithEmail:(NSString *)email {
    self.apiPath = TPString(@"/user/salt?email=%@",email);
    self.requestDict[@"email"] = email;
    [self connectWithRquestMethod:HTTPMethodPOST];
}
@end
