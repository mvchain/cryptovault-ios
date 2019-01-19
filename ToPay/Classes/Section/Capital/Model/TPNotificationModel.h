//
//  TPNotificationModel.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/3.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPNotificationModel : NSObject

@property (nonatomic , copy) NSString              * messageId;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSString              * read;
@property (nonatomic , copy) NSString              * updatedAt;
@property (nonatomic , copy) NSString              * createdAt;
@property (nonatomic , copy) NSString              * messageType;

@end
