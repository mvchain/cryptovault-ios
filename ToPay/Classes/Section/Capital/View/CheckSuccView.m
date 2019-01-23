//
//  CheckSuccView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "CheckSuccView.h"

@implementation CheckSuccView


- (IBAction)onTap:(id)sender {
    if(self.onTap){
        self.onTap();
        [self removeFromSuperview];
        
    }
}

@end
