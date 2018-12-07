//
//  TPChainTakeViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/20.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPChainTakeViewController.h"
#import "TPComTextView.h"
#import "TPTransView.h"
@interface TPChainTakeViewController ()
@property (nonatomic, assign) NSDecimalNumber *balanceNum;

@property (nonatomic, strong) UILabel *balanceLab;

@property (nonatomic, strong) TPComTextView *takeText;

@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation TPChainTakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.customNavBar.title = @"余额取出";
    
    [self createUI];
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/debit" success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            self.balanceNum = responseObject[@"data"];
            self.balanceLab.text = TPString(@"余额：%@",self.balanceNum);
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"获取余额失败");
    }];
    
    
    
    
}

-(void)createUI
{
    UIView *backView = [[UIView alloc] init];
    [backView setLayer:5 WithBackColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@10);
         make.top.equalTo(@(StatusBarAndNavigationBarHeight + 10));
         make.right.equalTo(self.view).with.offset(-10);
         make.height.equalTo(@173);
     }];
    
    TPComTextView *takeText = [[TPComTextView alloc] initWithTitle:@"取出余额" WithDesc:@"输入取出余额"];
    [takeText.comTextField addTarget:self action:@selector(didChangeText:) forControlEvents:UIControlEventEditingChanged];
    
    takeText.comTextField.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:takeText];
    self.takeText = takeText;
    [takeText mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.top.equalTo(@19);
         make.width.equalTo(backView.mas_width);
         make.height.equalTo(@71);
     }];
    
    UILabel *balanceLab = [YFactoryUI YLableWithText:@"余额：1235.1234" color:TP8EColor font:FONT(12)];
    [takeText addSubview:balanceLab];
    self.balanceLab = balanceLab;
    [balanceLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(takeText.comTextField);
        make.height.equalTo(@16);
        make.top.equalTo(takeText.comTitleLabel);
    }];
    
    UILabel *promptLab = [YFactoryUI YLableWithText:@"取出后，余额会转入vpay应用内使用" color:[UIColor colorWithHex:@"#E86636"] font:FONT(12)];
    [backView addSubview:promptLab];
    
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(takeText.comTextField).with.offset(4);
         make.height.equalTo(@16);
         make.top.equalTo(takeText.mas_bottom).with.offset(2);
     }];
    
    UIButton *confirmBtn = [YFactoryUI YButtonWithTitle:@"确认" Titcolor:TPD5Color font:FONT(15) Image:nil target:self action:@selector(confirClcik)];
    confirmBtn.userInteractionEnabled = NO;
//
    [confirmBtn setLayer:22 WithBackColor:TPEBColor];
    
    self.confirmBtn = confirmBtn;
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.bottom.equalTo(self.view).with.offset(-(HOME_INDICATOR_HEIGHT + 54));
         make.height.equalTo(@44);
         make.width.equalTo(@343);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)didChangeText:(UITextField *)textF
{
    if (textF.text.length >0)
    {
        self.confirmBtn.userInteractionEnabled = YES;
        [self.confirmBtn setLayer:22 WithBackColor:TPMainColor];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


-(void)confirClcik
{
    TPTransView *transV = [TPTransView createTransferView];
 
    [transV showMenuWithAlpha:YES];
    __block TPTransView *TPTransV = transV;
    [transV.pasView setEndEditBlock:^(NSString *text)
    {
        NSLog(@"text:%@",text);
        if (text.length == 6)
        {
        [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:@"asset/debit" parameters:@{@"password":text,
                                            @"value":self.takeText.comTextField.text}
            success:^(id responseObject, BOOL isCacheObject)
         {
             if ([responseObject[@"code"] isEqual:@200])
             {
                 
                 [TPTransV showMenuWithAlpha:NO];
                 
                 [TPNotificationCenter postNotificationName:TPTakeOutSuccessNotification object:nil];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }
            failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
         {
             NSLog(@"划账失败 %@",error);
         }];

        }
        
    }];
    
}


-(void)dealloc
{
    
    [TPNotificationCenter removeObserver:self];
}

@end
