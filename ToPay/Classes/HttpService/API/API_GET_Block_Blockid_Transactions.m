#import "API_GET_Block_Blockid_Transactions.h"
@implementation API_GET_Block_Blockid_Transactions
- (void)sendReuqestWithBlockid:(NSString*)blockid
                      PageSize:(NSNumber *)pageSize
                 transactionId:(NSNumber *)transactionId {
    self.apiPath = TPString(@"/block/%@/transactions",blockid);
    self.requestDict[@"pageSize"] = pageSize;
    self.requestDict[@"transactionId"] = transactionId;
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
