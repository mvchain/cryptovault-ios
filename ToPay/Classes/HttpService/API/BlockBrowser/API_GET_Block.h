#import "ServModel.h"
@interface API_GET_Block : ServModel
- (void)sendReuqestWithBlockId:(NSNumber *)blockId
                      pageSize:(NSNumber *)pageSize;

@end
