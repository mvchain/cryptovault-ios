// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-04 11:43
// summary:获取24小时最新，最高，最低价格, 每10秒钟更新
#import "API_GET_Transaction_Pair_Tickers.h"
@implementation API_GET_Transaction_Pair_Tickers
- (void)sendRequestWithPairId:(NSNumber *)pairId {
  NSString *apiPath = @"/transaction/pair/tickers";
  self.requestDict[@"pairId"] = pairId; //pairId
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodGET];
}
@end
