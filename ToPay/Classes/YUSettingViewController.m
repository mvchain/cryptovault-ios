//
//  YUSettingViewController.m
//  Forum
//
//  Created by yxyyxy on 20/04/2018.
//  Copyright © 2018 yxy. All rights reserved.
//

#import "YUSettingViewController.h"
#import "YUNormalNavBarView.h"
#import "YUHamburgerButton.h"
#import "UIView+YUStyle.h"
#import "YUSettingTableViewCellEntity.h"
#import "YUSettingTableViewCell.h"
#import "UIButton+Bootstrap.h"
#import "UITableView+YUTableView.h"
#import "YUUserInfoStore.h"
#import "SDImageCache.h"
#import "MBProgressHUD+Add.h"
#import "YYImageCache.h"
#import "YYDiskCache.h"
#import "YYWebImageManager.h"
#import "PersonalProfileViewController.h"
#import "IF_NOT_LOGIN_SHOW_LOGINVC.h"
@interface YUSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *  dataArrays ;

@end

@implementation YUSettingViewController


- (id)init{
    
    
    self = [super init];
    if(self){
        
        _dataArrays =[[NSMutableArray alloc]init];
        
        
        
    }
    
    return self;
}
- (void)viewDidLoad {
    
    [self initNav];
    [super viewDidLoad];
    [_yu_tableView yu_frameBelowNavrbarWithoutTabBar];
    _yu_tableView.delegate= self;
    _yu_tableView.dataSource= self;
    [_yu_tableView registerNib:[UINib nibWithNibName:@"YUSettingTableViewCell" bundle:nil] forCellReuseIdentifier:YUSettingTableViewCellEntity_CELLID];
    _yu_tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [_yu_tableView y_setHeight:145];
    
    NSArray * images = @[@"", @""];
    NSArray * titles  = @[@"个人资料", @"清理缓存"];
    
    for ( int i = 0; i < images.count; i++ )
    {
        YUSettingTableViewCellEntity * entity = [[YUSettingTableViewCellEntity alloc] init];
        entity.yu_title                       = titles[i];
        entity.yu_imaName                     = images[i];
        [_dataArrays addObject:entity];
    }
    [_yu_loginBtn y_setAlign:5];
    
    [_yu_loginBtn y_bottomFromView:_yu_tableView distance:91];
    [_yu_loginBtn yu_smallCircleStyle];
    [_yu_loginBtn setHidden:![YUUserInfoStore isLogin]];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
      [_yu_loginBtn y_setAlign:5];
      [_yu_loginBtn y_bottomFromView:_yu_tableView distance:91];
}

- (IBAction)exit_touch:(id)sender {
    
    [YUUserInfoStore clearLoginInfo];
    [MBProgressHUD showSuccess:@"已退出" toView:self.view];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) initNav{
    __weak typeof (self) weakSelf = self ;
    
    [self addNormalNavBar:@"通用设置"];
    [self.normalNavbar setLeftButtonAsReturnButton];
    self.normalNavbar.leftButton.onClick = ^(id sender ) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArrays.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView cellByIndexPath:indexPath dataArrays:_dataArrays];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YUSettingTableViewCellEntity * entity = _dataArrays[indexPath.row];
    return entity.yu_cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
            if([YUUserInfoStore isLogin]){
            PersonalProfileViewController * person =[[PersonalProfileViewController alloc]init];
                
                [self.navigationController pushViewController:person animated:YES];
                
            }else{
                [IF_NOT_LOGIN_SHOW_LOGINVC atViewController:self];
                
            }
             break;
        }
           
        case 1:
        {
            [MBProgressHUD showMessag:@"请理中" toView:self.view];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
            // 清空磁盘缓存，带进度回调
             YYImageCache *cache = [YYWebImageManager sharedManager].cache;
            [cache.diskCache removeAllObjects];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
            break;
        default:
            break;
    }
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
