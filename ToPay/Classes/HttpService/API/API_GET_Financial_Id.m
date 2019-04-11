// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-09 13:07
// summary:理财详情查看(购买时详情获取)
#import "API_GET_Financial_Id.h"
@implementation API_GET_Financial_Id
- (void)sendRequestWithIdField:(NSNumber *)idField {
  NSString *apiPath = @"/financial/{id}";
  apiPath = [apiPath stringByReplacingOccurrencesOfString:@"{id}" withString:idField.stringValue];
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodGET];
}
@end
