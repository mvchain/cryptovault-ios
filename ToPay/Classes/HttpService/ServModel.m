//
//  ServModel.m
//  English
//
//  Created by jimi on 2018/5/10.
//  Copyright © 2018年 jimi. All rights reserved.
//

#import "ServModel.h"

@implementation ServModel
- (id)init
{
    self = [super init];
    if(self){
        NSString *server_path = [QuickGet getCurrentServerUrl];
        
        _apiDomainUrl = [[QuickGet getCurrentServerUrl] substringToIndex:server_path.length -2] ;
    }
    return self;
}
- (void)connectWithRquestMethod:(HTTPMethod)rquestMethod
{
    [self updateHttpHeadTokenForEachAPI];
    NSAssert(self.apiPath !=nil && self.apiPath.length > 0, @"  #### apiPath must not be null～@@@@@") ;
    NSAssert(self.onSuccess, @" ### onSuccess must not be null ~ @@@@");
    NSAssert(self.onError, @" ### onError must not be null ~ @@@@");
    NSAssert(self.onEndConnection, @" ### onEndConnection must not be null ~ @@@@");
    [[YUNetworkManager defaultManager] sendRequestMethod:rquestMethod
                                               serverUrl:self.apiDomainUrl
                                                 apiPath:self.apiPath
                                              parameters:self.requestDict progress:^(NSProgress * _Nullable progress) {
    }
                                                 success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary*)responseObject;
        if([dict[@"code"] intValue] == 200) {
            self.onSuccess(dict[@"data"]);
        }else {
            self.onError(dict[@"message"],[dict[@"code"] integerValue]);
        }
        self.onEndConnection();
    } failure:^(NSString * _Nullable errorMessage, NSInteger responseCode) {
        if (responseCode == 401) {
           
        }
        // not 401
        self.onError(errorMessage,responseCode);
        self.onEndConnection();
    }];
}

/* set newst token  */
- (void)updateHttpHeadTokenForEachAPI
{
    NSString *authToken = [TPLoginUtil userInfo].token;
    if (!authToken) return; // no token exit
    YUNetworkManager *manager = [YUNetworkManager defaultManager];
    // token ,for every connect
    [ manager.sessionManager.requestSerializer setValue:authToken forHTTPHeaderField:@"Authorization"];
    // language
    [ manager.sessionManager.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    // buildVersion
   
}

- (NSMutableDictionary *) requestDict
{
    if(_requestDict)return _requestDict;
    _requestDict = [[NSMutableDictionary alloc]init];
    return _requestDict;
}
@end
