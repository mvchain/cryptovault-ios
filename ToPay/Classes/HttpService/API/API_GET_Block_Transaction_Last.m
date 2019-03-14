#import "API_GET_Block_Transaction_Last.h"
@implementation API_GET_Block_Transaction_Last
- (void)sendReuqestWithPageSize:(NSNumber *)pageSize {
    self.apiPath = @"/block/transaction/last";
    self.requestDict[@"pageSize"] = pageSize;
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
