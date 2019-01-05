//
//  YUCellEntity.m
//  Forum
//
//  Created by yxyyxy on 02/04/2018.
//  Copyright © 2018 yxy. All rights reserved.
//

#import "YUCellEntity.h"

@implementation YUCellEntity

- (void)fillDataByNSDictionary:(NSDictionary *) dict {
    
}

- (NSString *)cellId { 
    
    if(_cellId) return _cellId ;
    _cellId = NSStringFromClass([self class]);
    return _cellId;
}
- (id)init{
    self = [super init];
    if(self){
        _yu_cellHeight = -1 ;
        
    }
    return self ;
    
}
- (Class)yu_relativeClass
{
    if(_yu_relativeClass) return _yu_relativeClass;
    Class selfClass = [self class];
    NSString * selfClassStr = NSStringFromClass(selfClass);
    NSString * cellClassStr = [selfClassStr stringByReplacingOccurrencesOfString:@"Entity" withString:@""];
    _yu_relativeClass = NSClassFromString(cellClassStr);
    return _yu_relativeClass ;
    
}

- (CGFloat)yu_cellHeight {
    if(_yu_cellHeight>=0)return _yu_cellHeight;
    return UITableViewAutomaticDimension;
}
@end
