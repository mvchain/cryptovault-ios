#import "ServModel.h"
@interface API_GET_Block_Blockid_Transactions : ServModel
- (void)sendReuqestWithBlockid:(NSString*)blockid
                      PageSize:(NSNumber *)pageSize
                 transactionId:(NSNumber *)transactionId
;@end
