//
//  TPTokenKindViewController.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//


#import "TPStartViewController.h"
#import "TPTokenBottomView.h"
#import "TPAssetModel.h"

@interface TPTokenKindViewController : TPStartViewController

//- (instancetype) initWithChainStyle:(TPChainStyle)chainStyle;
@property (nonatomic, strong) TPAssetModel *assetModel;


@end
