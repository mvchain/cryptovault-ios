#import "API_GET_Block_Last.h"
@implementation API_GET_Block_Last
- (void)sendReuqest;
{
    self.apiDomainUrl = [QuickGet getExplorerPath];
    self.apiPath = @"/block/last";
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
