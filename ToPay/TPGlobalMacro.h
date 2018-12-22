//
//  TPGlobalMacro.h
//  ToPay
//
//  Created by 蒲公英 on 2018/11/12.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#ifndef TPGlobalMacro_h
#define TPGlobalMacro_h


#define KBounds [UIScreen mainScreen].bounds
#define KWidth KBounds.size.width
#define KHeight KBounds.size.height
#define KWidthScale   (KWidth / 375.0)


#define YColorA(r, g, b, a) [[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0] colorWithAlphaComponent:0.5]
#define YColor(r, g, b) YColorA((r), (g), (b), 255)
#define YRandomColor YColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define TPMainColor [UIColor colorWithHex:@"#007AFF"]
#define TP59Color [UIColor colorWithHex:@"#595971"]
#define TP8EColor [UIColor colorWithHex:@"#8E8E9E"]
#define TPF6Color [UIColor colorWithHex:@"#F6F7FB"]
#define TPA7Color [UIColor colorWithHex:@"#A7A9B8"]
#define TPD5Color [UIColor colorWithHex:@"#D5D7E6"]
#define TPC1Color [UIColor colorWithHex:@"#C1C2CC"]
#define TPEBColor [UIColor colorWithHex:@"#EBF1FB"]
#define TPD5Color [UIColor colorWithHex:@"#D5D7E6"]

//字符串转换
#define TPString(FORMAT, ...) [NSString stringWithFormat:FORMAT,##__VA_ARGS__]

//设置字体大小
#define FONT(F) [UIFont systemFontOfSize:F]

// 弱引用
#define TPWeakSelf __weak typeof(self) weakSelf = self;

//USER-DEFAULT
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


#define TPNotificationCenter [NSNotificationCenter defaultCenter]

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 44.f : 44.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define StatusBarAndNavigationBarHeight  (iPhoneX ? 88.f : 64.f)


#define RefreshEndHeader [self.baseTableView.mj_header endRefreshing];
#define RefreshEndFooter [self.baseTableView.mj_footer endRefreshing];

#endif /* TPGlobalMacro_h */
