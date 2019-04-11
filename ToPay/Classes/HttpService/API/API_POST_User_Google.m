// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-09 13:07
// summary:20190403验证谷歌验证码,通过后返回新token
#import "API_POST_User_Google.h"
@implementation API_POST_User_Google
- (void)sendRequestWithGoogleCode:(NSNumber *)googleCode {
  NSString *apiPath = @"/user/google?googleCode=#";
  apiPath = [apiPath stringByReplacingOccurrencesOfString:@"#" withString: googleCode.stringValue];
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodPOST];
}
@end
