// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-04 11:43
// summary:获取24小时最新，最高，最低价格, 每10秒钟更新
#import "ServModel.h"
@interface API_GET_Transaction_Pair_Tickers : ServModel
- (void)sendRequestWithPairId:(NSNumber *)pairId;
@end
