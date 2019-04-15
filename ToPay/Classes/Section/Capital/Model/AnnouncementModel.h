//
//    AnnouncementModel.h
//
//    Create by 蒲公英 on 12/4/2019
//    Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementModel : NSObject

@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
