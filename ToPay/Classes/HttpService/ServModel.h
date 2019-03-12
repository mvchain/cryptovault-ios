//
//  ServModel.h
//  English
//
//  Created by jimi on 2018/5/10.
//  Copyright © 2018年 jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUNetworkManager.h"

typedef NS_ENUM(NSUInteger, ServModelState) {
    ServModelState_ConnectionError,
    ServModelState_BusinessLogicError,
    ServModelState_Success
};
typedef void(^succBlock)(id responseData);

typedef void(^errBlock)(NSString *reason ,NSInteger code  );

@interface ServModel : NSObject
// api domain ,for example :@"https://mvc.com",note: "https" can not lack
@property (copy,nonatomic) NSString * apiDomainUrl ;
// api path,for example :@"/api/sendMessage"
@property (copy,nonatomic) NSString * apiPath ;
// api body reuqst url
@property (strong,nonatomic) NSMutableDictionary * requestDict ;
// write code in this block when request  succ
@property (copy,nonatomic) succBlock onSuccess ;
// write code in this block when request  err
@property (copy,nonatomic) errBlock onError ;
// write code in this block when http conn end 
@property (copy,nonatomic) void(^onEndConnection)(void);
// default request
- (void)connectWithRquestMethod:(HTTPMethod)rquestMethod;
@end
