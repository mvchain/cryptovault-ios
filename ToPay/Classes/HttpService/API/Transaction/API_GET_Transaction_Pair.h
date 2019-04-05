// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-04 11:43
// summary:获取交易对,很少变动,本地必须缓存
#import "ServModel.h"
@interface API_GET_Transaction_Pair : ServModel
- (void)sendRequestWithPairType:(NSNumber *)pairType;
@end
