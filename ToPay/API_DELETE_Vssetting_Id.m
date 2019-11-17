// https://github.com/objc94 
// created by swagger-occode api maker at 2019-10-21 09:33
// summary:面签参数-删除
#import "API_DELETE_Vssetting_Id.h"
@implementation API_DELETE_Vssetting_Id
- (void)sendRequestWithIdField:(NSString *)idField {
  NSString *apiPath = @"/vssetting/{id}";
  apiPath = [apiPath stringByReplacingOccurrencesOfString:@"{id}" withString:idField];
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodDELETE];
}
@end
