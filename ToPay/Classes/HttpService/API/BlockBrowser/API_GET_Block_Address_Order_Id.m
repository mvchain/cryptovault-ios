#import "API_GET_Block_Address_Order_Id.h"
@implementation API_GET_Block_Address_Order_Id
- (void)sendReuqestWithId:(NSString*)idfield
{
    self.apiDomainUrl = [QuickGet getExplorerPath];
    self.apiPath = TPString(@"/block/address/order/%@",idfield);
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
