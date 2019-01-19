//
//  TPMnemonicDisplayViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMnemonicDisplayViewModel.h"

@implementation TPMnemonicDisplayViewModel
- (TPRegisterResponseModel *)cacheRegisterResponseModel {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    TPRegisterResponseModel *model = (TPRegisterResponseModel *)[cache objectForKey:kRegResponseCacheKey];
    return model;
}
@end
