#import "ServModel.h"
@interface API_GET_Block_Address_Order : ServModel
- (void)sendReuqestWithId:(NSNumber *)idfield
                 pageSize:(NSNumber *)pageSize
               publicKey :(NSString *)publicKey;

@end
