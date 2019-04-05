// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-04 11:43
// summary:获取交易对,很少变动,本地必须缓存
#import "API_GET_Transaction_Pair.h"
@implementation API_GET_Transaction_Pair
- (void)sendRequestWithPairType:(NSNumber *)pairType {
  NSString *apiPath = @"/transaction/pair";
  self.requestDict[@"pairType"] = pairType; //1 VRT交易 2余额交易,不传为所有
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodGET];
}
@end
