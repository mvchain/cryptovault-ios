//
//  TPInvitedRegisterViewModel.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInvitedRegisterViewModel.h"
#import "TPInviteRegFirstPageTableViewCellEntity.h"
#import "TPRecommendedUserModel.h"
#import "TPInviteRegSecondPageItemTableViewCellEntity.h"
#import "TPInviteRegSecondPageTableViewCellEntity.h"
#import "NIMScanner.h"
#import <Social/Social.h>
#import "TPInvitedNoDataCellEntity.h"
@class TPInviteRegSecondPageItemTableViewCellEntity;
@implementation TPInvitedRegisterViewModel
yudef_lazyLoad(NSMutableArray<YUCellEntity*>, dataArray, _dataArray)
- (id)init {
    self =[super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)loadNewData:(bool_id_block)complete {
    [self getInvitedCodeWithCallBack:^(BOOL isSucc, NSString *info) {
        if (isSucc) {
            TPInviteRegSecondPageTableViewCellEntity *second =  (TPInviteRegSecondPageTableViewCellEntity*)self.dataArray[1];
            [second initDataArray]; //重置第二页的数据的
            [self loadNewRecommandUserListWithId:0 complete:^(BOOL isSucc, id data) {
                if(isSucc){
                     complete(YES,nil);
                }else {
                    complete(NO,data);
                }
            }];
        }else {
             complete(NO,info);
        }
    }];
    
}
- (void)loadMoreData:(bool_id_block)complete  {
    TPInviteRegSecondPageTableViewCellEntity *second =  (TPInviteRegSecondPageTableViewCellEntity*)self.dataArray[1];
    if([second.dataArray.lastObject isKindOfClass:TPRecommendedUserModel.class]) {
        TPRecommendedUserModel *model = (TPRecommendedUserModel *)second.dataArray.lastObject ;
        [self loadNewRecommandUserListWithId:model.userId
                                    complete:complete];
    }
}
// 获取邀请码
- (void)getInvitedCodeWithCallBack:(void (^)(BOOL, NSString *))complete {
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"user/invitation"
                                          parameters:nil
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     TPInviteRegFirstPageTableViewCellEntity *entity = (TPInviteRegFirstPageTableViewCellEntity *)self.dataArray[0];
                                                     entity.inviteCode = res[@"data"];
                                                     complete(YES,res[@"data"]);
                                                 }else {
                                                     complete(NO,res[@"message"]);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 NSLog(@"%@",[error description]);
                                                 complete(NO,@"网络错误");
                                             } ];
}

// 获取推荐列表
- (void)loadNewRecommandUserListWithId:(NSInteger )Id complete:(void(^)(BOOL isSucc,id data)) complete {
    NSDictionary *postDict = @{@"inviteUserId":@(Id),@"pageSize":@10};
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"user/recommend"
                                          parameters:postDict
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 TPInviteRegSecondPageTableViewCellEntity *second =  (TPInviteRegSecondPageTableViewCellEntity*)self.dataArray[1]; // 第二页
                                                 if ([res[@"code"] intValue] == 200) {
                                                     NSArray *arr = res[@"data"];
                                                     if(![arr isKindOfClass:NSNull.class] ) {
                                                         for (NSDictionary *dic in arr) {
                                                             TPInviteRegSecondPageItemTableViewCellEntity *entity = [[TPInviteRegSecondPageItemTableViewCellEntity alloc] init] ;
                                                             entity.userModel = [[TPRecommendedUserModel alloc] initWithDictionary:dic];
                                                                                                                [second.dataArray addObject:entity];
                                                        }
                                                     }else {
                                                         //  无数据
                                                         if(Id == 0) {
                                                             //无数据，
                                                             TPInvitedNoDataCellEntity *en = [[TPInvitedNoDataCellEntity alloc] init];
                                                             [second.dataArray addObject:en];
                                                         }
                                                     }
                                                     complete(YES,res[@"data"]);
                                                 }else {
                                                     complete(NO,res[@"message"]);
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 NSLog(@"%@",[error description]);
                                                 complete(NO,@"网络错误");
                                             } ];
}
- (void)setUp {
    _curPage = 0;
    TPInviteRegFirstPageTableViewCellEntity *entity = [[TPInviteRegFirstPageTableViewCellEntity alloc] init];
    entity.inviteCode = @"aabab";
    entity.website = @"https://www.bzvp.net";
   
    TPInviteRegSecondPageTableViewCellEntity *entity2 = [[TPInviteRegSecondPageTableViewCellEntity alloc] init];
    [self.dataArray addObject:entity]; // 邀请码界面加入
    [self.dataArray addObject:entity2];
}
@end
