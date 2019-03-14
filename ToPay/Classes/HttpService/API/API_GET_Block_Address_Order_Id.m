#import "API_GET_Block_Address_Order_Id.h"
@implementation API_GET_Block_Address_Order_Id
- (void)sendReuqestWithId:(NSString*)idfield
{
    self.apiPath = TPString(@"/block/address/order/%@",idfield);
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
