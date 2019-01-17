//
//  TPAccountSafeViewModel.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/17.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TPAccountSafeItemTableViewCellEntity.h"

@interface TPAccountSafeViewModel : NSObject
@property (strong, nonatomic) NSMutableArray<TPAccountSafeItemTableViewCellEntity *> *dataArrays ;
@end


