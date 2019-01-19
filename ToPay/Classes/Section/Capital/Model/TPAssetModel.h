//
//  TPAssetModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/30.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPAssetModel : NSObject

@property (nonatomic , copy) NSString              * tokenName;
@property (nonatomic ) CGFloat   value;
@property (nonatomic ) CGFloat   ratio;
@property (nonatomic , copy) NSString              * tokenId;

@end
