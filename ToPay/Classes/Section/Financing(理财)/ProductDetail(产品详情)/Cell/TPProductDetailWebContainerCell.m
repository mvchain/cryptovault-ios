//
//  TPProductDetailWebContainerCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/12.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPProductDetailWebContainerCell.h"
#import "TPProductDetailWebContainerCellEntity.h"
@interface TPProductDetailWebContainerCell () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (assign,nonatomic) BOOL isAlreadyLoadH5;
@end

@implementation TPProductDetailWebContainerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.webView.delegate = self;
    self.webView.dataDetectorTypes=UIDataDetectorTypeNone;
    self.isAlreadyLoadH5 = NO;
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView.scrollView bk_addObserverForKeyPath:@"contentSize" task:^(id target) {
         [self notifiyUpdateHeight];
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    TPProductDetailWebContainerCellEntity *myEn = (TPProductDetailWebContainerCellEntity *)entity;
    if(!self.isAlreadyLoadH5) {
        NSString *url_str = myEn.url;
        NSURL *url = [NSURL URLWithString:url_str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _isAlreadyLoadH5 = YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self notifiyUpdateHeight];
}
- (void)notifiyUpdateHeight {
    
    CGSize fit = [_webView sizeThatFits:CGSizeZero];
    self.entity.yu_cellHeight = fit.height;
    if(self.yu_delegate) {
        [self.yu_delegate yu_cellMessageNotify:@"web-height-update" content:nil sender:_webView];
    }
}
- (void)dealloc {
    [self.webView.scrollView bk_removeAllBlockObservers];
    
}
@end
