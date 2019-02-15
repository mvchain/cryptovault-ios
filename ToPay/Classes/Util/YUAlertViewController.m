//
//  YUAlertViewController.m
//  Photo
//
//  Created by yxyyxy on 16/06/2018.
//  Copyright © 2018 叶夏云. All rights reserved.
//

#import "YUAlertViewController.h"

@implementation YUAlertViewControllerStyle
@end

@implementation YUAlertViewControllerConfirmOnlyStyle
@end

@implementation YUAlertViewControllerCancelWithConfirmStyle
@end

@implementation YUMethod

- (void) exec {
    
    if( _object && _msg_selector ) {
        if( [_object respondsToSelector:_msg_selector] ) {
            // 消除警告
            IMP imp = [_object methodForSelector:_msg_selector];
            void (*exec_func)(id, SEL) = (void *)imp;
            exec_func(_object, _msg_selector);
        }
    }
}
@end

@interface YUAlertViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *alertTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancleLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layt_iconImageH;
@property (copy,nonatomic) void(^confirmAction)(id sender);
@property (copy,nonatomic) void(^cancleAction)(id sender);
@property (copy,nonatomic) void(^confirmOnlystyleMaker)(YUAlertViewControllerConfirmOnlyStyle * style) ;
@property (copy,nonatomic) void(^confirmWithCanclestyleMaker)(YUAlertViewControllerCancelWithConfirmStyle * style) ;
@property (strong,nonatomic) NSArray * stylePropertyStrArrays ;
@property (strong,nonatomic) NSDictionary<NSString *,id> * stylePropertyWithUIViewMap;
@property (strong,nonatomic) YUAlertViewControllerStyle * style;
@property (strong,nonatomic) YUMethod * styleMethod ;


@end

@implementation YUAlertViewController

#pragma mark lazy load

- (YUMethod *)styleMethod {
    
    if( !_styleMethod ) {
        _styleMethod = [[YUMethod alloc]init];
    }
    return _styleMethod;
}
- (NSDictionary<NSString *,id> *)stylePropertyWithUIViewMap {
    if( !_stylePropertyWithUIViewMap ) {
        /* map */
        _stylePropertyWithUIViewMap = @{ @"yu_confirmButtonTitle":_firstButton ,
                                         @"yu_cancleButtonTitle":_secondButton ,
                                         @"yu_alertTitle":_alertTitleLabel ,
                                         @"yu_alertContent":_alertContentLabel ,
                                         @"yu_alertInfoImage":_iconImageView,
                                         @"yu_apperanceType":self.styleMethod};
    }
    return _stylePropertyWithUIViewMap;
}

- (id)init {
    self =[super init];
    if(self){
        
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.styleMethod.object = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initAction];
    
    /* 视图加载完成后再调用外部写好的样式配置闭包 */
    if( [_style isMemberOfClass:[YUAlertViewControllerCancelWithConfirmStyle class]] ) {
        _confirmWithCanclestyleMaker((YUAlertViewControllerCancelWithConfirmStyle *)_style);
    }else if( [_style isMemberOfClass:[YUAlertViewControllerConfirmOnlyStyle class]] ) {
        _confirmOnlystyleMaker((YUAlertViewControllerConfirmOnlyStyle*)_style);
    }
}
- (void)initViews {
    
    _contentBgView.layer.cornerRadius = 5.0;
    _contentBgView.layer.masksToBounds = YES;
    NSArray * buttons = @[_firstButton,_secondButton];
    for( UIButton * button in buttons ) {
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
    }
    if( ![self isShouldShowCancleButton] ) {
        /* 不要显示取消按钮 */
        [_secondButton removeConstraint:_cancleWidth];
        _cancleLeading.constant = 0;
        NSLayoutConstraint * zeroWidthConstraint = [NSLayoutConstraint constraintWithItem:_secondButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
        [_secondButton addConstraint:zeroWidthConstraint];
    }
}

- (void)initAction {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (BOOL)isShouldShowCancleButton {
   return  _cancleAction != nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if( object == _style  ) {
        [self handleStyleModelChange:keyPath];
    }
}
/**
 处理属性对应的 对象（视图，对象）

 @param keyPath 属性的字符串
 */
- (void)handleStyleModelChange:(NSString *)keyPath {
    
    id relate = self.stylePropertyWithUIViewMap[keyPath]; //取出属性对应的view
    id propertyValue = [_style valueForKey:keyPath];
    if( [propertyValue isKindOfClass:[NSString class]] ) {
        // 属性值为字符串 如 标题，正文，按钮标题等等...
        if ( [relate isKindOfClass:[UILabel class]] ) {
            [((UILabel *)relate) setText:propertyValue];
        }else if( [relate isKindOfClass:[UIButton class]] ) {
             [((UIButton *)relate) setTitle:propertyValue forState:UIControlStateNormal];
        }
    }else if( [propertyValue isKindOfClass:[UIImage class]] ) {
        // 属性值为 UIImage
        if( [relate isKindOfClass:[UIImageView class]] ) {
            [((UIImageView *)relate) setImage:propertyValue];
        }
    }else if( [propertyValue isKindOfClass:[NSNumber class]] ) {
        NSInteger k = [((NSNumber *)propertyValue) integerValue];
        int isShowImage =  k & (1 << 4) ;
        if( isShowImage ) {
            _layt_iconImageH.constant = 0;
        }else {
            _layt_iconImageH.constant = 50;
        }
        // 0xf ~ 二进制 1111 作掩码 取出低4位
        int apperType = k & (0xf);
        YUAlertViewApperanceType apper = (YUAlertViewApperanceType)apperType;
        switch (apper) {
            case YUAlertViewApperanceTypeNormal:
            {
                self.styleMethod.msg_selector = @selector(normalStyle);
               break;
            }
            case YUAlertViewApperanceTypeDanager:
            {
                self.styleMethod.msg_selector = @selector(dangerStyle);
                break;
            }
            case YUAlertViewApperanceTypeWaring:
            {
                self.styleMethod.msg_selector = @selector(waringStyle);
                break;
            }
            case YUAlertViewApperanceTypeNetError:
            {
                self.styleMethod.msg_selector = @selector(networkErrorStyle);
                break;
            }
            case YUAlertViewApperanceTypeCamera:
            {
                self.styleMethod.msg_selector = @selector(cameraStyle);
                break;
            }
            default:
                break;
        }
        [self.styleMethod exec]; // 执行相应的样式方法
  
    }
}

/**
    监听style的所有属性
 */
- (void)registerStyleObserver {
    _stylePropertyStrArrays = @[@"yu_confirmButtonTitle",@"yu_cancleButtonTitle",@"yu_alertTitle",@"yu_alertContent",@"yu_alertInfoImage",@"yu_apperanceType"];
    for( NSString *propertyStr in _stylePropertyStrArrays ) {
        SEL sel = NSSelectorFromString(propertyStr);
        if( [_style respondsToSelector:sel] ){
            [_style addObserver:self forKeyPath:propertyStr options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}

- (void)yu_setting:(void(^)(YUAlertViewControllerConfirmOnlyStyle * style)) styleMaker
     confirmAction:(void(^)(id sender ))confirmAction; {
    _style = [[YUAlertViewControllerConfirmOnlyStyle alloc]init];
    [self registerStyleObserver];
    self.confirmAction = confirmAction;
    self.confirmOnlystyleMaker = styleMaker;
}

- (void)yu_setting:(void(^)(YUAlertViewControllerCancelWithConfirmStyle * style)) styleMaker
      confirmAction:(void(^)(id sender ))confirmAction
         cancleAction:(void(^)(id sender ))cancleAction  {
    _style = [[YUAlertViewControllerCancelWithConfirmStyle alloc]init];
    [self registerStyleObserver];
    self.confirmAction = confirmAction;
    self.cancleAction = cancleAction;
    self.confirmWithCanclestyleMaker = styleMaker;
}

- (void)tap {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if( self->_confirmAction ) {
            self->_confirmAction(sender);
        }
    }];
}

- (IBAction)secondButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if( self->_cancleAction ) {
            self->_cancleAction(sender);
        }
    }];
}

#pragma mark 样式各类
- (void)dangerStyle {
/* 风险样式，比如如删除 */
    [_firstButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:87/255.0 blue:87/255.0 alpha:1]];
    [_firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_secondButton setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [ _secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
/* 普通样式 */
- (void)normalStyle {
    [_firstButton setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:150/255.0 blue:254/255.0 alpha:1]];
    [_firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_secondButton setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [ _secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
/* 警告样式，比如提示账号出现异常 */
- (void)waringStyle {
    [_firstButton setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:150/255.0 blue:254/255.0 alpha:1]];
    [_firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_secondButton setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [ _secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_iconImageView setImage:[UIImage imageNamed:@"waring"]];
    
}
/* 网络错误样式 */
- (void)networkErrorStyle {
    [_firstButton setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:150/255.0 blue:254/255.0 alpha:1]];
    [_firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_secondButton setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [ _secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_iconImageView setImage:[UIImage imageNamed:@"no-wifi"]];
}

/* 照相机样式 */

- (void)cameraStyle {

    [_firstButton setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:150/255.0 blue:254/255.0 alpha:1]];
    [_firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_secondButton setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [ _secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_iconImageView setImage:[UIImage imageNamed:@"cam"]];
}

- (void)dealloc {
  
    for( NSString * propertyStr in _stylePropertyStrArrays ) {
        SEL sel = NSSelectorFromString(propertyStr);
        if( [_style respondsToSelector:sel] ) {
            [_style removeObserver:self forKeyPath:propertyStr];
        }
    }
}

@end
