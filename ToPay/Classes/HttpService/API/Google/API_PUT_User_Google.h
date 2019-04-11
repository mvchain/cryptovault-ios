// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-10 18:20
// summary:20190403开启谷歌验证,开启后重新返回通过验证的token(0关闭 1开启)
#import "ServModel.h"
@interface API_PUT_User_Google : ServModel
- (void)sendRequestWithPassword:(NSString *)password status:(NSNumber *)status googleCode:(NSNumber *)googleCode googleSecret:(NSString *)googleSecret;
@end
