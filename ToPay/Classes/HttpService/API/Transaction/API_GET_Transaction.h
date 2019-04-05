// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-04 11:43
// summary:获取挂单列表
#import "ServModel.h"
@interface API_GET_Transaction : ServModel
- (void)sendRequestWithIdField:(NSNumber *)idField pageSize:(NSNumber *)pageSize pairId:(NSNumber *)pairId transactionType:(NSNumber *)transactionType type:(NSNumber *)type;
@end
