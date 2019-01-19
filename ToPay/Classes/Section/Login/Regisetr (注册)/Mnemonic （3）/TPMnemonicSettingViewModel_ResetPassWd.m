//
//  TPMnemonicSettingViewModel_ResetPassWd.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMnemonicSettingViewModel_ResetPassWd.h"

@implementation TPMnemonicSettingViewModel_ResetPassWd

- (void)checkoutMnemonicsWithEmail:(NSString *)email
                         mnemonics:(NSArray<NSString *> *)mnemonics
                          complete:(void (^)(BOOL, NSString *))complete {
    
    NSMutableString *mnmonics_str = [[NSMutableString alloc]initWithString:@""];
    int index = 0 ;
    for (NSString *mnemonic in mnemonics) {
        ++index;
        [mnmonics_str appendString:mnemonic];
        if (!(index == mnemonics.count))
            [ mnmonics_str appendString:@","];
    }
    NSDictionary *postDict =@{@"email":email,@"resetType":@2,@"value":mnmonics_str};
    
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"user/reset"
                                           parameters:postDict
                                              success:^(id responseObject, BOOL isCacheObject) {
                                                  
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                                  if ([res[@"code"] intValue] == 200 ) {
                                                  
                                                      complete(YES,res[@"data"]);
                                                  }else {
                                                      complete(NO,res[@"message"]);
                                                  }
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  complete(NO,@"网络错误");
                                              }];
}

- (NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *)downDataArrays {
    if( !_downDataArrays ) {
        _downDataArrays = [[ NSMutableArray<TPMemonicStatusCollectionViewCellModel *> alloc]init];
        
    }
    return _downDataArrays;
}


- (NSMutableArray<TPMemonicStatusCollectionViewCellModel *> *)upDataArrays {
    if (!_upDataArrays) {
        _upDataArrays = [[NSMutableArray<TPMemonicStatusCollectionViewCellModel *> alloc] init];
    }
    return _upDataArrays;
}

- (void)setDownDataArraysByArr:(NSArray *)arr {
    for( NSString *str in arr ) {
        TPMemonicStatusCollectionViewCellModel *model = [[TPMemonicStatusCollectionViewCellModel alloc]init];
        model.title = str ;
        [self.downDataArrays addObject:model];
        
    }
}
@end
