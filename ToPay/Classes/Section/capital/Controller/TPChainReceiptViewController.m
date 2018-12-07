//
//  TPChainReceiptViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPChainReceiptViewController.h"
#import "TPUserInfo.h"
#import "NIMScanner.h"
@interface TPChainReceiptViewController ()
@property (nonatomic, strong) UIImageView * iconImgV;
@property (nonatomic, strong) UILabel * addressLab;
@property (nonatomic, strong) UIImageView * QRView;

@end

@implementation TPChainReceiptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.title = @"BTC收款";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"share_icon_black"]];
    [self.customNavBar setOnClickRightButton:^
    {
        
    }];
    
    
    [self createUI];
    
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    TPUserInfo *userInfo = (TPUserInfo *)[listCache objectForKey:TPUserInfoKey];
    [self.iconImgV setHeader:userInfo.headImage];
    
    
    [self setUpQRimgView];
}

-(void)setUpQRimgView
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/address" parameters:@{@"tokenId":self.assetModel.tokenId} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"收款地址：%@",responseObject[@"data"]);
             self.addressLab.text = responseObject[@"data"];
             [NIMScanner qrImageWithString:responseObject[@"data"] avatar:nil completion:^(UIImage *image)
              {
                  self.QRView.image = image;
              }];
         }
     }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"获取币种收款地址----失败");
     }];
}


-(void)createUI
{
    UIView *backView = [[UIView alloc] init];
    [backView setLayer:16 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(119 + STATUS_BAR_HEIGHT));
        make.width.equalTo(@335);
        make.height.equalTo(@392);
    }];
    
    UIImageView *iconImgV = [YFactoryUI YImageViewWithimage:nil];
    self.iconImgV = iconImgV;
    [self.view addSubview:iconImgV];
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(backView);
        make.centerY.equalTo(backView.mas_top);
        make.size.equalTo(@56);
    }];
    
    
    UILabel *descLab = [YFactoryUI YLableWithText:@"BTC收款地址" color:TP59Color font:FONT(14)];
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(backView);
        make.top.equalTo(iconImgV.mas_bottom).with.offset(13);
        make.height.equalTo(@19);
    }];
    
    UILabel *addressLab = [YFactoryUI YLableWithText:@"0x2051dd2b...a196ccc2448" color:TP8EColor font:FONT(13)];
    self.addressLab = addressLab;
    [self.view addSubview:addressLab];
    
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(backView);
         make.top.equalTo(descLab.mas_bottom).with.offset(6);
         make.height.equalTo(@19);
         make.width.equalTo(@153);
     }];
    
    UIImageView *QRView = [YFactoryUI YImageViewWithimage:nil];
    self.QRView = QRView;
    QRView.backgroundColor = YRandomColor;
    [self.view addSubview:QRView];
   
    [QRView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(backView);
         make.top.equalTo(addressLab.mas_bottom).with.offset(19);
         make.size.equalTo(@245);
     }];
    
    UIImageView *logoImgV = [YFactoryUI YImageViewWithimage:nil];
    logoImgV.backgroundColor = YRandomColor;
    [self.view addSubview:logoImgV];
    
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(backView.mas_bottom).with.offset(45);
        make.size.equalTo(@56);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
