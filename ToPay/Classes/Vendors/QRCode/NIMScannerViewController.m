//
//  NIMScannerViewController.m
//  NIMKit
//
//  Created by FengKun on 2018/3/7.
//  Copyright © 2018年 NetEase. All rights reserved.
//

#import "NIMScannerViewController.h"
#import "NIMScannerBorder.h"
#import "NIMScannerMaskView.h"
#import "NIMScanner.h"
//#import "NIMGlobalMacro.h"
//#import "UIView+NIM.h"
//#import "UIViewController+BackButtonHandler.h"
/// 控件间距
#define kControlMargin  72.0
/// 相册图片最大尺寸
#define kImageMaxSize   CGSizeMake(1000, 1000)

static NSString * typeID = @"evn:f:";
static NSString * typeGroupID = @"evn:g:";
static NSString * typeRoomID = @"evn:r:";

@interface NIMScannerViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/// 名片字符串
@property (nonatomic) NSString *cardName;
/// 头像图片
@property (nonatomic) UIImage *avatar;
/// 完成回调
@property (nonatomic, copy) void (^completionCallBack)(NSString * );
@end

@implementation NIMScannerViewController {
    /// 扫描框
    NIMScannerBorder *scannerBorder;
    /// 扫描器
    NIMScanner *scanner;
    /// 提示标签
    UILabel *tipLabel;
}

- (instancetype)initWithCardName:(NSString *)cardName avatar:(UIImage *)avatar completion:(void (^)(NSString *))completion
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.cardName = cardName;
        self.avatar = avatar;
        self.completionCallBack = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    
    // 实例化扫描器
    __weak typeof(self) weakSelf = self;
    scanner = [NIMScanner scanerWithView:self.view scanFrame:scannerBorder.frame completion:^(NSString *stringValue)
    {
       [weakSelf selectNTESType:stringValue];
       // 关闭
       [weakSelf clickCloseButton];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [scannerBorder startScannerAnimating];
    [scanner startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [scannerBorder stopScannerAnimating];
    [scanner stopScan];
}

#pragma mark - 监听方法
/// 点击关闭按钮
- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 点击相册按钮
- (void)clickAlbumButton {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        tipLabel.text = @"无法访问相册";
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.view.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    
    [self showDetailViewController:picker sender:nil];
}

/// 点击名片按钮
- (void)clickCardButton
{
    NIMScanerCardViewController *vc = [[NIMScanerCardViewController alloc]initWithCardName:self.cardName avatar:self.avatar];
    
    [self showViewController:vc sender:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [self resizeImage:info[UIImagePickerControllerOriginalImage]];
    NSLog(@"%f %f",image.size.width,image.size.height);
    // 扫描图像
    [NIMScanner scaneImage:image completion:^(NSArray *values) {
        NSLog(@"values.firstObject:%@",values.firstObject);
        if (values.count > 0)
        {
            [self selectNTESType:values.firstObject];
            
            [self dismissViewControllerAnimated:NO completion:^{
                [self clickCloseButton];
            }];
        } else {
            tipLabel.text = @"没有识别到二维码，请选择其他照片";
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (UIImage *)resizeImage:(UIImage *)image {
    
    if (image.size.width < kImageMaxSize.width && image.size.height < kImageMaxSize.height) {
        return image;
    }
    
    CGFloat xScale = kImageMaxSize.width / image.size.width;
    CGFloat yScale = kImageMaxSize.height / image.size.height;
    CGFloat scale = MIN(xScale, yScale);
    CGSize size = CGSizeMake(image.size.width * scale, image.size.height * scale);
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

-(void)selectNTESType:(NSString *)stringValue
{
    NSString *typeStr = [stringValue substringToIndex:6];
    NSString *conStr = [stringValue substringFromIndex:6];
    if ([typeStr isEqualToString:typeID])
    {
        // 完成回调
        self.completionCallBack(conStr);
    }
    else if ([typeStr isEqualToString:typeGroupID])
    {
        self.completionCallBack(conStr);
    }
    else if ([typeStr isEqualToString:typeRoomID])
    {
        self.completionCallBack(conStr);
    }
    else
    {
        self.completionCallBack(stringValue);
    }
}

#pragma mark - 设置界面
- (void)prepareUI
{
    [self prepareNavigationBar];
    [self prepareScanerBorder];
    [self prepareOtherControls];
}

/// 准备提示标签和名片按钮
- (void)prepareOtherControls {
    
    // 1> 提示标签
    tipLabel = [[UILabel alloc] init];
    
    tipLabel.text = @"将二维码放在上面的框内，即可快速识别";
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor colorWithHex:@"#b1b1bc"];//NIMKit_UIColorFromRGB(0xb1b1bc);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [tipLabel sizeToFit];
    tipLabel.centerX = scannerBorder.centerX;
    tipLabel.top = scannerBorder.bottom + 12;
    [self.view addSubview:tipLabel];
    
    // 2> 名片按钮
    UIButton *cardButton = [[UIButton alloc] init];
    
    [cardButton setTitle:@"我的二维码 " forState:UIControlStateNormal];
    [cardButton setImage:[UIImage imageNamed:@"qrcode-yellow"] forState:UIControlStateNormal];
    [cardButton setImage:[UIImage imageNamed:@"qrcode-yellow"] forState:UIControlStateHighlighted];
    cardButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cardButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
    cardButton.imageEdgeInsets = UIEdgeInsetsMake(0, 85, 0, 0);
    cardButton.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    [cardButton sizeToFit];
    cardButton.center = CGPointMake(tipLabel.center.x, CGRectGetMaxY(tipLabel.frame) + kControlMargin);
    
    [self.view addSubview:cardButton];
    
    [cardButton addTarget:self action:@selector(clickCardButton) forControlEvents:UIControlEventTouchUpInside];
}

/// 准备扫描框
- (void)prepareScanerBorder
{
    CGFloat width = self.view.bounds.size.width - 135;
    scannerBorder = [[NIMScannerBorder alloc] initWithFrame:CGRectMake(0, 124 + StatusBarAndNavigationBarHeight, width, width)];
    scannerBorder.centerX = self.view.centerX;
    scannerBorder.tintColor = self.navigationController.navigationBar.tintColor;
    
    [self.view addSubview:scannerBorder];
    
    NIMScannerMaskView *maskView = [NIMScannerMaskView maskViewWithFrame:self.view.bounds cropRect:CGRectMake(scannerBorder.left + 2, scannerBorder.top + 2, scannerBorder.width - 4, scannerBorder.height -4)];
    
    [self.view insertSubview:maskView atIndex:0];
}

/// 准备导航栏
- (void)prepareNavigationBar
{   // 2> 标题
    self.title = @"扫一扫";
    
    // 3> 左右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(clickAlbumButton)];
}

- (BOOL)navigationShouldPopOnBackButton
{
//    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定返回上一界面?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    return NO;
}




@end
