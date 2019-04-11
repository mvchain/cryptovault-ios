// https://github.com/objc94 
// created by swagger-occode api maker at 2019-04-09 13:07
// summary:20190403验证谷歌验证码,通过后返回新token
#import "ServModel.h"
@interface API_POST_User_Google : ServModel
- (void)sendRequestWithGoogleCode:(NSNumber *)googleCode;
@end
