#import "API_GET_Block_Address_Exist.h"
@implementation API_GET_Block_Address_Exist
- (void)sendReuqestWithPublicKey:(NSString *)publicKey {
    self.apiPath = @"/block/address/exist";
    self.requestDict[@"publicKey"] = publicKey;
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
