// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-10 18:20
// summary:20190403开启谷歌验证,开启后重新返回通过验证的token(0关闭 1开启)
#import "API_PUT_User_Google.h"
@implementation API_PUT_User_Google
- (void)sendRequestWithPassword:(NSString *)password status:(NSNumber *)status googleCode:(NSNumber *)googleCode googleSecret:(NSString *)googleSecret {
  NSString *apiPath = @"/user/google";
  self.requestDict[@"password"] = password; //登录密码
  self.requestDict[@"status"] = status; //开关设置,0关闭 1开启
  self.requestDict[@"googleCode"] = googleCode; //谷歌验证码
  self.requestDict[@"googleSecret"] = googleSecret; //google secret
  self.apiPath  = apiPath;
  [self connectWithRquestMethod:HTTPMethodPUT];
}
@end
