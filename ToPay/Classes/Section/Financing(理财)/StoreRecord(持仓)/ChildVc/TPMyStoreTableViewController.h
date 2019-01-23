//
//  TPMyStoreTableViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"


@class MyStoreItemModel;

@interface TPMyStoreTableViewController : UIViewController
yudef_property_assign(int, financialType);
@property (strong,nonatomic) void (^onTableViewDidSelect)(MyStoreItemModel *model,int financialType );

@end


