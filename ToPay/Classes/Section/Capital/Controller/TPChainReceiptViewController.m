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
#import <Social/Social.h>
@interface TPChainReceiptViewController ()
@property (nonatomic, strong) UIImageView * iconImgV;
@property (nonatomic, strong) UIButton * addressBtn;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIImageView * QRView;
@property (nonatomic, strong) UIButton *cpBtn;

@end

@implementation TPChainReceiptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  ;
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"share_icon_black"]];
    
    __weak typeof (self) wsf = self;
    
    [self.customNavBar setOnClickRightButton:^
    {
        UIImage *shot = [QuickMaker makeImageWithView:wsf.view withSize:wsf.view.bounds.size];
        
        UIImage *imageToShare =shot;
        
        
        NSArray *items = @[imageToShare];
        [QuickDo shareToSystem:items target:wsf  success:^(bool isok) {
            
        }];
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
             [self.addressBtn setTitle:responseObject[@"data"] forState:UIControlStateNormal];
             
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
    
    
    UILabel *descLab = [YFactoryUI YLableWithText:TPString(@"%@收款地址",self.assetModel.tokenName) color:TP59Color font:FONT(14)];
    self.descLab = descLab;
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(backView);
        make.top.equalTo(iconImgV.mas_bottom).with.offset(13);
        make.height.equalTo(@19);
    }];
    
    UIButton *addressBtn = [YFactoryUI YButtonWithTitle:@"0x2051dd2b...a196ccc2448" Titcolor:TP8EColor font:FONT(13) Image:nil target:self action:@selector(copyClick)];
    //[YFactoryUI YLableWithText:@"0x2051dd2b...a196ccc2448" color:TP8EColor font:FONT(13)];
    self.addressBtn = addressBtn;
    [self.view addSubview:addressBtn];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(backView);
         make.top.equalTo(descLab.mas_bottom).with.offset(6);
         make.height.equalTo(@19);
         make.width.equalTo(@153);
     }];
    UIButton *copyBtn = [YFactoryUI YButtonWithTitle:@"" Titcolor:nil font:nil Image:[UIImage imageNamed:@"copy_icon"] target:self action:@selector(copyClick)];
    self.cpBtn = copyBtn;
    [self.view addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(addressBtn.mas_right).with.offset(6);
        make.size.equalTo(@15);
        make.centerY.equalTo(addressBtn);
    }];
    
    UIImageView *QRView = [YFactoryUI YImageViewWithimage:nil];
    self.QRView = QRView;
    QRView.backgroundColor = YRandomColor;
    [self.view addSubview:QRView];
   
    [QRView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(backView);
         make.top.equalTo(addressBtn.mas_bottom).with.offset(19);
         make.size.equalTo(@245);
     }];
    
    UIImageView *logoImgV = [YFactoryUI YImageViewWithimage:nil];

}

-(void)copyClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.addressBtn.titleLabel.text;
    [SVProgressHUD showSuccessWithStatus:@"已复制"];
    [SVProgressHUD dismissWithDelay:1.0];
}

@end
