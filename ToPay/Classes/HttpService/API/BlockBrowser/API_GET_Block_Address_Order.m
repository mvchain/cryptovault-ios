#import "API_GET_Block_Address_Order.h"
@implementation API_GET_Block_Address_Order
- (void)sendReuqestWithId:(NSNumber *)idfield
                 pageSize:(NSNumber *)pageSize
               publicKey :(NSString *)publicKey  {
    self.apiDomainUrl = [QuickGet getExplorerPath];
    self.apiPath = @"/block/address/order";
    self.requestDict[@"id"] = idfield;
    self.requestDict[@"pageSize"] = pageSize;
    self.requestDict[@"publicKey"] = publicKey ;
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
