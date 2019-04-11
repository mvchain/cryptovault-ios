// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-09 13:07
// summary:20190403获取谷歌验证信息
#import "API_GET_User_Google.h"
@implementation API_GET_User_Google
- (void)sendRequest {
  NSString *apiPath = @"/user/google";
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodGET];
}
@end
