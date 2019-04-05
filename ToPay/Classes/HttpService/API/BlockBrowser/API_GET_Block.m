#import "API_GET_Block.h"
@implementation API_GET_Block
- (void)sendReuqestWithBlockId:(NSNumber *)blockId pageSize:(NSNumber *)pageSize {
    self.apiPath = @"/block";
    self.apiDomainUrl = [QuickGet getExplorerPath];
    self.requestDict[@"blockId"] = blockId;
    self.requestDict[@"pageSize"] = pageSize;
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
