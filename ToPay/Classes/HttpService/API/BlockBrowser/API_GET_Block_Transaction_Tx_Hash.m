#import "API_GET_Block_Transaction_Tx_Hash.h"
@implementation API_GET_Block_Transaction_Tx_Hash
- (void)sendReuqestWithHash:(NSString*)hash
{
    self.apiDomainUrl = [QuickGet getExplorerPath];
    self.apiPath = [NSString stringWithFormat:@"/block/transaction/tx/%@",hash];
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
