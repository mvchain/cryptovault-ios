//
//  TPTransDetailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/26.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTransDetailViewController.h"
#import "TPTransDetailCell.h"
#import "TPTransDetailModel.h"

@interface TPTransDetailViewController ()
@property (nonatomic, strong) NSArray *titleArray, *contentArray;

@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIImageView *iconImgV;
@end

@implementation TPTransDetailViewController

static NSString  *TPDetailCellId = @"detailCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.title = @"详情";
    self.view.backgroundColor = TPF6Color;
    
    if ([self.tokenTopic.classify isEqualToString:@"0"])
    {
        self.titleArray = @[@"金额：",@"交易手续费：",@"收款地址：",@"",@"交易哈希："];
        self.contentArray = @[@"",@"",@"",@"",@""];
    }
        else
    {
        self.titleArray = @[@"金额："];
        self.contentArray = @[@""];
    }
    
    
    

    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:TPString(@"asset/transaction/%@",self.tokenTopic.id) success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            NSLog(@"%@",responseObject[@"data"]);
            TPTransDetailModel *transModel = [TPTransDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSMutableArray *conArr = [NSMutableArray array];
            
            if ([transModel.classify isEqualToString:@"0"])
            {
                if ([transModel.status isEqualToString:@"0"] || [transModel.status isEqualToString:@"1"])
                {
                    [self setStatuText:@"转账中" WithImg:@"Details_pending_icon"];
                }
                    else if ([transModel.status isEqualToString:@"2"])
                {
                    [self setStatuText:@"转账成功" WithImg:@"Details_succss_icon"];
                }
                    else if ([transModel.status isEqualToString:@"3"])
                {
                    [self setStatuText:@"转账失败" WithImg:@"Details_failure_icon"];
                }
            }
                else if ([transModel.classify isEqualToString:@"1"])
            {
                [self setStatuText:TPString(@"%@ 交易%@",transModel.tokenName,[self.tokenTopic.transactionType isEqualToString:@"1"] ? @"收入":@"支出") WithImg:@"trand_icon_2"];
            }
                else if ([transModel.classify isEqualToString:@"2"])
            {
                [self setStatuText:TPString(@"%@ 众筹%@",transModel.orderRemark,[self.tokenTopic.transactionType isEqualToString:@"1"] ? @"收入":@"支出") WithImg:@"Crowdfunding_icon_2"];
            }
                else if ([transModel.classify isEqualToString:@"3"])
            {
                if ([self.tokenTopic.transactionType isEqualToString:@"1"])
                {
                    [self setStatuText:@"收入成功" WithImg:@"Details_succss_icon"];
                }
                    else
                {
                    [self setStatuText:@"取出成功" WithImg:@"Details_succss_icon"];
                }
            }
            
            self.timeLab.text = [transModel.createdAt conversionTimeStamp];
            
            if ([self.tokenTopic.classify isEqualToString:@"0"])
            {
                [conArr addObject:transModel.value];
                [conArr addObject:transModel.fee];
                [conArr addObject:transModel.toAddress];
                [conArr addObject:@""];
                [conArr addObject:transModel.blockHash];
            }
                else
            {
                [conArr addObject:transModel.value];
            }
            
            
            self.contentArray = conArr;
            
            [self.baseTableView reloadData];
            NSLog(@"根据转账交易Id获取转账详情");
        }else
        {
            [self showErrorText:responseObject[@"data"]];
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"根据转账交易Id获取转账详情失败 %@",error);
        [self showErrorText:@"获取转账详情失败"];
    }];
    
    
    UIImageView *iconImgV = [YFactoryUI YImageViewWithimage:nil];
    self.iconImgV = iconImgV;
    [self.view addSubview:iconImgV];
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(StatusBarAndNavigationBarHeight + 23));
        make.size.equalTo(@40);
    }];
    
    UILabel *statusLab = [YFactoryUI YLableWithText:@"转账成功" color:TP59Color font:FONT(16)];
    self.statusLab = statusLab;
    [self.view addSubview:statusLab];
    
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view);
         make.top.equalTo(iconImgV.mas_bottom).with.offset(6);
         make.height.equalTo(@21);
     }];
    
    
    UILabel *timeLab = [YFactoryUI YLableWithText:@"2017年12月18日 16:23:56" color:TP8EColor font:FONT(12)];
    [self.view addSubview:timeLab];
    self.statusLab = statusLab;
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view);
        make.top.equalTo(iconImgV.mas_bottom).with.offset(34);
        make.height.equalTo(@16);
    }];
    
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(timeLab.mas_bottom).with.offset(19);
        make.height.equalTo(@320);
        make.width.equalTo(@(KWidth));
    }];
}

//-(void)


-(void)setStatuText:(NSString *)text WithImg:(NSString *)img
{
    self.statusLab.text = text;
    self.iconImgV.image = [UIImage imageNamed:img];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPTransDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TPDetailCellId];
    if (!cell)
        cell = [[TPTransDetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPDetailCellId isCopy:indexPath.row == 3 ? YES : NO];
    cell.titleLab.text = self.titleArray[indexPath.row];
    
    if (self.titleArray.count == 1)
    {
        cell.conLab.text = TPString(@"%.4f",[self.contentArray[indexPath.row] floatValue]);
    }else
    cell.conLab.text = self.contentArray[indexPath.row];
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tokenTopic.classify isEqualToString:@"0"])
    {
        if (indexPath.row == 0 || indexPath.row == 1)
            return 32;
        else
            return  50;
    }
        else
    {
        return 68;
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:))
    {
        TPTransDetailCell *cell = (TPTransDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; // 黏贴板
        [pasteBoard setString:cell.conLab.text];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        //        if (tableView == self.tableView) {
        CGFloat cornerRadius = 10.f;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        BOOL addLine = NO;
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
        }
            else if (indexPath.row == 0)
        {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
        }
            else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        }
            else
        {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        
        layer.path = pathRef;
        CFRelease(pathRef);
        //颜色修改
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.5f].CGColor;

//        if (addLine == YES) {
//            CALayer *lineLayer = [[CALayer alloc] init];
//            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
//            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
//            [layer addSublayer:lineLayer];
//        }
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
    }
}

@end
