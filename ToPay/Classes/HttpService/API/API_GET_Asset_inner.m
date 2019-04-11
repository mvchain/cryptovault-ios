//
//  API_GET_Asset_inner.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/11.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "API_GET_Asset_inner.h"

@implementation API_GET_Asset_inner
- (void)sendRequestWithAddress:(NSString *)address {
    self.apiPath = @"/asset/inner";
    self.requestDict[@"address"] = address;
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
