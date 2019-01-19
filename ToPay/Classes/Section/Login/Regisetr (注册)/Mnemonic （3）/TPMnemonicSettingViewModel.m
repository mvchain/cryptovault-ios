//
//  TPMnemonicSettingViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/15.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMnemonicSettingViewModel.h"
@interface TPMnemonicSettingViewModel()
@property (strong, nonatomic) NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *upDataArrays;
@property (strong, nonatomic) NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *downDataArrays;
- (TPRegisterInfoModel *)cacheRegisterModel;

- (TPRegisterResponseModel *)cacheRegisterResponseModel;
@end
@implementation TPMnemonicSettingViewModel
#pragma mark lazy load
/**
 * 上半view
 */
- (NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *)upDataArrays {
    if (!_upDataArrays) {
        _upDataArrays = [[NSMutableArray<TPMemonicStatusCollectionViewCellModel *> alloc] init];
    }
    return _upDataArrays;
}
/**
 * 下半view 的dataSoure
 */
- (NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *)downDataArrays {
    if (!_downDataArrays) {
        int vis[99];
        memset(vis, 0, 99);
        _downDataArrays = [[NSMutableArray<TPMemonicStatusCollectionViewCellModel *> alloc] init];
        NSArray *mnmonics = self.cacheRegisterResponseModel.mnemonics;
        for( int i = 0 ; i<mnmonics.count ;i++ ) {
            int rnd = [self getRandomNumber:0 to:(int)mnmonics.count-i];
            int index = 0;
            int res = -1 ; // 取出结果
            for (int j = 0; j<mnmonics.count ;j++) {
                if (!vis[j]) {
                    if (index == rnd) {
                        res = j;
                        vis[j] = 1;
                        break;
                    }
                    index++;
                }
            }
            printf("max：%d, rand：%d  ,%d\n",(int)mnmonics.count-i-1,rnd,res);
            TPMemonicStatusCollectionViewCellModel *model = [[TPMemonicStatusCollectionViewCellModel alloc] init];
            model.title = self.cacheRegisterResponseModel.mnemonics[res];
            model.isSelected = NO;
            [self.downDataArrays addObject:model];
        }
        
    }
    return _downDataArrays;
}

#pragma mark http service
- (void)checkoutMnemonicsWithEmail:(NSString *)email
                         mnemonics:(NSArray<NSString *> *)mnemonics
                          complete:(void(^)(BOOL isSucc,NSString *reasonInf))complete {
    NSMutableString *mnmonics_str = [[NSMutableString alloc]initWithString:@""];
    int index = 0 ;
    for (NSString *mnemonic in mnemonics) {
        ++index;
        [mnmonics_str appendString:mnemonic];
        if (!(index == mnemonics.count))
            [ mnmonics_str appendString:@","];
        
    }
    NSDictionary *postDict = @{@"email":email,@"mnemonics":mnmonics_str};
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/mnemonics"
                                           parameters:postDict
                                              success:^(id responseObject, BOOL isCacheObject) {
                                
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                                  if ([res[@"code"] intValue] == 200 ) {
                                                       TPLoginModel *loginM = [TPLoginModel mj_objectWithKeyValues:responseObject[@"data"]];
                                                      [TPLoginUtil loginInitSetting:loginM] ; //初始化登录信息
                                                      complete(YES,nil);
                                                  }else {
                                                      complete(NO,res[@"message"]);
                                                  }
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 complete(NO,@"网络错误");
                                              }];
}

#pragma mark local method

- (TPRegisterInfoModel *)cacheRegisterModel {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    TPRegisterInfoModel *model = (TPRegisterInfoModel *) [cache objectForKey:kReginfoModelCacheKey];
    return model;
}

- (TPRegisterResponseModel *)cacheRegisterResponseModel {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    TPRegisterResponseModel *model = (TPRegisterResponseModel *)[cache objectForKey:kRegResponseCacheKey];
    return model;
}

- (NSString *)emialAddr  {
    return self.cacheRegisterModel.email;
}
// get[0,to)
- (int)getRandomNumber:(int)from to:(int)to
{
    int num = arc4random() % to ;
    return num;
}

@end
