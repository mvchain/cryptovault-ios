//
//  TPBaseViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"

@interface TPBaseViewController ()

@end

@implementation TPBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(UITableView *)baseTableView
{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _baseTableView.backgroundColor = TPF6Color;//[YRandomColor colorWithAlphaComponent:0.2];
        _baseTableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_baseTableView];
        
//        [_baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.mas_equalTo(0);
//            make.height.mas_equalTo(KHeight);
//            make.width.mas_equalTo(KWidth);
//        }];
    }
    return _baseTableView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
