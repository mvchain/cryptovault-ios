//
//  TPMeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPMeViewController.h"
#import "TPLanguageViewController.h"
#import "TPAboutViewController.h"
#import "TPTransDetailViewController.h"
#import "TPLoginViewController.h"
#import "TPMeCell.h"
#import "TPMeHeaderView.h"
#import "TPCurrencyList.h"
#import "TPAccountSafeViewController.h"
#import "TPInvitedRegisterViewController.h"
#import "YUTMineCellTableViewCellEntity.h"
#import "YUSpaceTableViewCellEntity.h"
#import "YUMineLoginOutCellEntity.h"
@interface TPMeViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSourceImg;
@property (strong ,nonatomic) NSMutableArray<YUCellEntity*>* datarr ;

@end
@implementation TPMeViewController
static NSString  *TPMeCellCellId = @"meCell";

#pragma mark lzy
yudef_lazyLoad(NSMutableArray<YUCellEntity*>, datarr, _datarr)
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customNavBar.title = @"我的";
    self.customNavBar.hidden = YES;
    [self showSystemNavgation:NO];
    _dataSource = @[@"账户安全",@"邀请注册",@"语言",@"关于",];
    _dataSourceImg = @[@"mine_safe_icon",@"mine_invite_icon",@"language_icon",@"about_icon"];
    
    for(int i=0;i<_dataSource.count;i++){
        YUTMineCellTableViewCellEntity*en =  [[YUTMineCellTableViewCellEntity alloc ] init];
        en.title = _dataSource[i];
        en.image = [UIImage imageNamed:_dataSourceImg[i]];
        [self.datarr addObject:en];
    }
    YUSpaceTableViewCellEntity *en = [[YUSpaceTableViewCellEntity alloc]init];
    en.yu_cellHeight =  23;
    en.bgcolor = [UIColor colorWithHex:@"#F2F2F2"];
    [self.datarr addObject:en];
    
    YUMineLoginOutCellEntity *en_c = [[YUMineLoginOutCellEntity alloc] init];
    [self.datarr addObject:en_c];
    
    TPMeHeaderView *headerView = [[TPMeHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@(156+12+STATUS_BAR_HEIGHT));
    }];
    /*
     
     */
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(@0);
        make.top.equalTo(headerView.mas_bottom).with.offset(0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view);
    }];
    [self.view sendSubviewToBack:self.baseTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return   [tableView cellByIndexPath:indexPath dataArrays:self.datarr];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  self.datarr[indexPath.row].yu_cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        TPAccountSafeViewController *account =[[TPAccountSafeViewController alloc]init];
        [self.navigationController pushViewController:account animated:YES];
        
    }
    if (indexPath.row == 1){
        TPInvitedRegisterViewController *cv = [[TPInvitedRegisterViewController alloc] init];
        [self.navigationController pushViewController:cv animated:YES];
    }
    if (indexPath.row == 2)
    {
        TPLanguageViewController *languageVC = [[TPLanguageViewController alloc] init];
        [self.navigationController pushViewController:languageVC animated:YES];
    }
        else if (indexPath.row == 3)
    {
        TPAboutViewController *aboutVC = [[TPAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    
    if(indexPath.row == 5) {
        [self quitClcik];
        
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [QuickDo prettyTableViewCellSeparate:@[@3,@4,@5] cell:cell indexPath:indexPath];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)quitClcik
{
    //    NSLog(@"退出登录");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"您确定要退出ToPay吗？"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      if ([TPLoginUtil quitWithRemoveUserInfo])
                                      {
                                          [TPLoginUtil  quitWithRemoveUserInfo];
                                          [QuickDo logout];
                                          
                                      }
                                  }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //添加顺序和显示顺序相同
    [alertController addAction:cancelAction];
    [alertController addAction:resetAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
