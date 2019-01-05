//
//  YUCellProtocol.h
//  ScreamingCat
//
//  Created by 王志刚 on 2018/7/26.
//  Copyright © 2018年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YUCellDelegate <NSObject>

- (void)yu_cellMessageNotify:(NSString *)idf content:(id)content sender:(id)sender;

@end
