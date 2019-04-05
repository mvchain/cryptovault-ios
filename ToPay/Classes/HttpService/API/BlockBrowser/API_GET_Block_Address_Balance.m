//
//  API_GET_Block_Address_Balance.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/13.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "API_GET_Block_Address_Balance.h"

@implementation API_GET_Block_Address_Balance
- (void)sendReuqestWithPublicKey :(NSString *)publicKey {
    self.apiDomainUrl = [QuickGet getExplorerPath];
    self.apiPath = @"/block/address/balance";
    self.requestDict[@"publicKey"] = publicKey;
    [self connectWithRquestMethod:HTTPMethodGET];
    
}
@end
