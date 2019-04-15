// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-12 18:19
// summary:获取banner列表,不分页, 内容过多时需要删除
#import "API_GET_View_Banner.h"
@implementation API_GET_View_Banner
- (void)sendRequest {
  NSString *apiPath = @"/view/banner";
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodGET];
}
@end
