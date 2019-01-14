//
//  TPGuiderViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPRgeisterViewModel.h"
#import "TPRegisterResponseModel.h"
@interface TPGuiderViewModel : NSObject
- (TPRegisterInfoModel *)cacheRegisterModel;
- (TPRegisterResponseModel *)cacheRegResponseModel;

@end


