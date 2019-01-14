//
//  TPGuiderViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPGuiderViewModel.h"
#import "TPSetPasswordViewModel.h"
@implementation TPGuiderViewModel

- (TPRegisterInfoModel *)cacheRegisterModel {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    TPRegisterInfoModel *model = (TPRegisterInfoModel *) [cache objectForKey:kReginfoModelCacheKey];
    return model;
}
- (TPRegisterResponseModel *)cacheRegResponseModel {
    YYCache *cache = [YYCache cacheWithName:kModelCache];
    TPRegisterResponseModel *model = (TPRegisterResponseModel *) [cache objectForKey:kRegResponseCacheKey];
    return model;
}
@end
