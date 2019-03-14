#import "API_GET_Block_Blockid.h"
@implementation API_GET_Block_Blockid
- (void)sendReuqestWithBlockid:(NSString*)blockid
{
    self.apiPath = TPString(@"/block/%@",blockid);
    [self connectWithRquestMethod:HTTPMethodGET];
}
@end
