// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-04 11:43
// summary:获取挂单列表
#import "API_GET_Transaction.h"
@implementation API_GET_Transaction
- (void)sendRequestWithIdField:(NSNumber *)idField pageSize:(NSNumber *)pageSize pairId:(NSNumber *)pairId transactionType:(NSNumber *)transactionType type:(NSNumber *)type {
  NSString *apiPath = @"/transaction";
  self.requestDict[@"id"] = idField; //当前订单id，不传为从第一条获取，否则以传入订单的id为初始记录继续增量查询
  self.requestDict[@"pageSize"] = pageSize; //(null)
  self.requestDict[@"pairId"] = pairId; //交易对id
  self.requestDict[@"transactionType"] = transactionType; //交易类型 1购买 2出售
  self.requestDict[@"type"] = type; //0上拉 1下拉
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodGET];
}
@end
