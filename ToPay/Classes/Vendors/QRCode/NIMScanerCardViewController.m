//
//  NIMScanerCardViewController.m
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//

#import "NIMScanerCardViewController.h"
#import "NIMScanner.h"
//#import "NIMPhotoLib.h"
//#import "UIView+NIM.h"
//#import "NIMAvatarImageView.h"
//#import "NIMGlobalMacro.h"
//#import "NIMKitInfo.h"
//#import "NIMCardMemberItem.h"
//#import "NIMKit.h"

@interface NIMScanerCardViewController ()
/// 名片字符串
@property (nonatomic) NSString *cardName;
/// 头像图片
@property (nonatomic) UIImage *avatar;


/// 群信息数组
//@property (nonatomic) NSMutableArray * data;

@property (nonatomic, strong) UIImageView *QRHeaderView;


@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * idLabel;
@end

@implementation NIMScanerCardViewController {
    UIImageView *cardImageView;
}

#pragma mark - 构造函数
- (instancetype)initWithCardName:(NSString *)cardName avatar:(UIImage *)avatar
{
    self = [super init];
    if (self)
    {
        self.cardName = cardName;
        self.avatar = avatar;
    }
    return self;
}

#pragma mark - 设置界面
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的二维码";
    
    
    [self createUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn-menu"] style:UIBarButtonItemStyleDone target:self action:@selector(moreMenu)];
}

-(void)createUI
{
    CGFloat width = self.view.bounds.size.width - 135;
    
    UIView *QRheaderV = [self createQRHeaderView];
    QRheaderV.top = 56;
    QRheaderV.left = self.view.width/2 - width/2;
    QRheaderV.size = CGSizeMake(width, 57);

    
    cardImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:cardImageView];
    cardImageView.centerX = self.view.width/2 - width/2;
    cardImageView.top = QRheaderV.bottom + 16;
    cardImageView.size = CGSizeMake(width, width);

    
    UIButton *scanningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanningBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [scanningBtn setTitleColor:TPMainColor forState:UIControlStateNormal];
    scanningBtn.titleLabel.font = FONT(16);
    [scanningBtn addTarget:self action:@selector(scanningQRcode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:scanningBtn];
    [scanningBtn sizeToFit];
    scanningBtn.left = self.view.width/2 - scanningBtn.width/2;
    scanningBtn.top = cardImageView.bottom + 54;
    scanningBtn.height = 16;
    
    
    /** 获取数据 并刷新UI */
//    [self getInfo:self.cardName];
}

//-(NTESGroupChatHeaderView *)QRGroupHeaderViewWithGroupArr:(NSArray *)groupArr
//{
//    if (!_QRGroupHeaderView)
//    {
//        _QRGroupHeaderView = [[NTESGroupChatHeaderView alloc]init];
//        _QRGroupHeaderView.frame = CGRectMake(0, 0, 57, 57);
//        [_QRGroupHeaderView initViewWithFrame:CGRectMake(0, 0, 57, 57) members:groupArr];
//        _QRGroupHeaderView.backgroundColor = UIFontColor;
//        _QRGroupHeaderView.layer.cornerRadius = 5;
//        _QRGroupHeaderView.clipsToBounds = YES;
//    }
//    return _QRGroupHeaderView;
//}

-(UIImageView *)QRHeaderView
{
    if (!_QRHeaderView)
    {
        _QRHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 57, 57)];
    }
    return _QRHeaderView;
}

-(UIView *)createQRHeaderView
{
    UIView *headerView = [[UIView alloc]init];
    [self.view addSubview:headerView];
    
    self.QRHeaderView.layer.cornerRadius = 5;
    [headerView addSubview:self.QRHeaderView];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = TPMainColor;
    titleLabel.font = FONT(16);
    titleLabel.text = @"用户/群/直播间名";
    [headerView addSubview:titleLabel];
    
    titleLabel.left = self.QRHeaderView.right + 12;
    titleLabel.top =  self.QRHeaderView.top + 8;
    self.titleLabel = titleLabel;
    
    UILabel *idLabel = [[UILabel alloc]init];
    idLabel.textColor = [UIColor redColor];
    idLabel.font = FONT(14);
    idLabel.text = @"ID/人数/ID";
    [headerView addSubview:idLabel];
    
    idLabel.left = self.QRHeaderView.right + 12;
    
    self.idLabel = idLabel;
    return headerView;
}

//-(void)getInfo:(NSString *)sessionId
//{
//    NIMKitInfo *info;
//    switch (self.qrType) {
//        case 0://点
//        {
//            info  = [[NIMKit sharedKit] infoByUser:sessionId option:nil];
//            [self refreshinfo:info WithQRid:NIMString(@"evn:f:%@",info.infoId)];
//        }
//            break;
//
//        case 1://群组
//        {
//            info = [[NIMKit sharedKit] infoByTeam:sessionId option:nil];
//            [self refreshinfo:info WithQRid:NIMString(@"evn:g:%@",info.infoId)];
//        }
//            break;
//
//        case 2://聊天室
//        {
//            //            info = [self userInfo:userId inChatroom:session.sessionId option:option];
//            //            - (NIMKitInfo *)userInfo:(NSString *)userId
//            //        inChatroom:(NSString *)roomId
//            //        option:(NIMKitInfoFetchOption *)option
//        }
//            break;
//
//        default:
//            break;
//    }
//
//
//}

//-(void)refreshinfo:(NIMKitInfo *)info WithQRid:(NSString *)QRId
//{
//    UIImage *avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info.avatarUrlString]]];
//    if (self.qrType == NIMQRTypeP2P)
//    {
//        [self.QRHeaderView nim_setImageWithURL:[NSURL URLWithString:info.avatarUrlString] placeholderImage:[UIImage imageNamed:@"10"] options:SDWebImageRetryFailed];
//    }
//
//
//    self.titleLabel.text = info.showName;
//    [self.titleLabel sizeToFit];
//    self.idLabel.text = NIMString(@"账号:%@",info.infoId);
//    self.idLabel.nim_top = self.titleLabel.nim_bottom + 9;
//    [self.idLabel sizeToFit];
//    [NIMScanner qrImageWithString:QRId avatar:avatar completion:^(UIImage *image)
//     {
//         cardImageView.image = image;
//     }];
//}


-(void)moreMenu
{
//    NIMDetailMenuView *moreMenuView = [NIMDetailMenuView createMenuViewWithTitleArr:@[@"扫描二维码",@"保存到相册",@"转发给朋友"] WithAlignmentType:MeunAlignmentTypeCenter];
//
//    [moreMenuView showMenuWithAlpha:YES];
//
//
//    moreMenuView.moreMenuEvent = ^(NSInteger currentIndex)
//    {
//        NSLog(@"%ld",(long)currentIndex);
//        if (currentIndex == 0)
//        {
//            NIMScannerViewController *scannerVC = [[NIMScannerViewController alloc]init];
//            [self.navigationController pushViewController:scannerVC animated:YES];
//        }
//
//        if (currentIndex == 1)
//        {
//            NSLog(@"保存到相册");
//            NIMPhotoLib *photoLib = [[NIMPhotoLib alloc]init];
//            [photoLib saveImageWithImg:cardImageView.image WithCompletion:^(NSError *error)
//             {
//                 [self.view makeToast:error ? @"保存失败":@"保存成功"];
//             }];
//        }
//
//        if (currentIndex == 2) {
//            NSLog(@"转发给朋友");
//        }
//    };
}

-(void)scanningQRcode
{
    NSLog(@"扫描二维码");
}

@end

